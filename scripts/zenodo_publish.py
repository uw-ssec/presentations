#!/usr/bin/env python3
"""Publish a presentation PDF to Zenodo.

On first run, creates a new deposition in the ``uw-ssec`` community.
On subsequent runs, opens a new version of the existing record and
replaces its file. The existing record is found by searching the
authenticated user's depositions for a unique keyword tag of the form
``uw-ssec-deck:<slug>``.

Driven by a per-deck ``zenodo.json`` metadata file next to the deck
sources. Run as::

    python scripts/zenodo_publish.py <deck-dir>

Required environment:
    ZENODO_TOKEN     Personal access token with ``deposit:write`` and
                     ``deposit:actions`` scopes.

Optional environment:
    ZENODO_SANDBOX   When set to ``true``/``1``, target
                     sandbox.zenodo.org instead of zenodo.org.

Versioning is CalVer (``YYYY.MM.DD``, UTC). When more than one publish
happens on the same day, the version becomes ``YYYY.MM.DD.N`` with
``N`` incremented from the previous record's version.
"""
from __future__ import annotations

import datetime
import json
import os
import sys
from pathlib import Path

import requests


COMMUNITY = "uw-ssec"
KEYWORD_PREFIX = "uw-ssec-deck"


def env(name: str, default: str | None = None) -> str | None:
    value = os.environ.get(name, default)
    if value is not None and value != "":
        return value
    return default


def required_env(name: str) -> str:
    value = env(name)
    if not value:
        sys.exit(f"missing required env var: {name}")
    return value


def truthy(value: str | None) -> bool:
    return (value or "").lower() in {"1", "true", "yes", "on"}


class Zenodo:
    def __init__(self, token: str, sandbox: bool = False) -> None:
        host = "sandbox.zenodo.org" if sandbox else "zenodo.org"
        self.api = f"https://{host}/api"
        self.session = requests.Session()
        self.session.headers["Authorization"] = f"Bearer {token}"

    def _call(self, method: str, url: str, **kwargs) -> requests.Response:
        kwargs.setdefault("timeout", 60)
        r = self.session.request(method, url, **kwargs)
        if not r.ok:
            sys.stderr.write(
                f"\nZenodo {method} {url} failed: {r.status_code}\n{r.text}\n"
            )
            r.raise_for_status()
        return r

    def find_existing(self, tag: str) -> dict | None:
        """Return the newest deposition matching the keyword tag, or None."""
        r = self._call(
            "GET",
            f"{self.api}/deposit/depositions",
            params={"q": f'keywords:"{tag}"', "size": 100, "sort": "mostrecent"},
        )
        matches = r.json()
        return matches[0] if matches else None

    def new_record(self) -> dict:
        r = self._call("POST", f"{self.api}/deposit/depositions", json={})
        return r.json()

    def new_version(self, deposit_id: int) -> dict:
        """Open a new draft version of a published record."""
        r = self._call(
            "POST",
            f"{self.api}/deposit/depositions/{deposit_id}/actions/newversion",
        )
        latest_draft_url = r.json()["links"]["latest_draft"]
        return self._call("GET", latest_draft_url).json()

    def replace_files(self, deposit: dict, file_path: Path) -> None:
        for f in deposit.get("files", []):
            self._call(
                "DELETE",
                f"{self.api}/deposit/depositions/{deposit['id']}/files/{f['id']}",
            )
        bucket = deposit["links"]["bucket"]
        with file_path.open("rb") as fh:
            self._call(
                "PUT",
                f"{bucket}/{file_path.name}",
                data=fh,
                timeout=600,
            )

    def set_metadata(self, deposit_id: int, metadata: dict) -> dict:
        r = self._call(
            "PUT",
            f"{self.api}/deposit/depositions/{deposit_id}",
            json={"metadata": metadata},
            headers={"Content-Type": "application/json"},
        )
        return r.json()

    def publish(self, deposit_id: int) -> dict:
        r = self._call(
            "POST",
            f"{self.api}/deposit/depositions/{deposit_id}/actions/publish",
        )
        return r.json()


def load_deck_metadata(deck_dir: Path) -> dict:
    cfg_path = deck_dir / "zenodo.json"
    if not cfg_path.is_file():
        sys.exit(f"missing {cfg_path}")
    return json.loads(cfg_path.read_text())


def next_calver(existing: dict | None) -> str:
    """Compute today's CalVer, bumping ``.N`` if it collides with the
    previous record's version (e.g. multiple publishes per day)."""
    today = datetime.datetime.now(datetime.timezone.utc).strftime("%Y.%m.%d")
    if existing is None:
        return today
    prev = ((existing.get("metadata") or {}).get("version") or "").strip()
    if prev == today:
        return f"{today}.2"
    if prev.startswith(f"{today}."):
        try:
            n = int(prev.rsplit(".", 1)[-1])
        except ValueError:
            return f"{today}.2"
        return f"{today}.{n + 1}"
    return today


def build_metadata(deck: dict, slug: str, version: str | None) -> dict:
    keywords = list(deck.get("keywords", []))
    tag = f"{KEYWORD_PREFIX}:{slug}"
    if tag not in keywords:
        keywords.append(tag)

    metadata: dict = {
        "upload_type": deck.get("upload_type", "presentation"),
        "title": deck["title"],
        "description": deck["description"],
        "creators": deck["creators"],
        "communities": [{"identifier": COMMUNITY}],
        "keywords": keywords,
        "access_right": "open",
        "license": deck.get("license", "cc-by-4.0"),
    }
    if "publication_date" in deck:
        metadata["publication_date"] = deck["publication_date"]
    if version:
        metadata["version"] = version
    return metadata


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        sys.exit("usage: zenodo_publish.py <deck-dir>")

    deck_dir = Path(argv[1]).resolve()
    if not deck_dir.is_dir():
        sys.exit(f"not a directory: {deck_dir}")

    token = required_env("ZENODO_TOKEN")
    sandbox = truthy(env("ZENODO_SANDBOX"))

    deck = load_deck_metadata(deck_dir)
    slug = deck.get("slug") or deck_dir.name
    pdf_name = deck.get("pdf") or f"{slug}.pdf"
    pdf_path = deck_dir / pdf_name
    if not pdf_path.is_file():
        sys.exit(f"PDF not found: {pdf_path}")

    zen = Zenodo(token, sandbox=sandbox)
    tag = f"{KEYWORD_PREFIX}:{slug}"
    existing = zen.find_existing(tag)

    version = next_calver(existing)
    print(f"version: {version}")
    metadata = build_metadata(deck, slug, version)

    if existing is None:
        print(f"no existing record for {tag}; creating new deposition")
        deposit = zen.new_record()
    else:
        print(
            f"found existing deposition {existing['id']}; opening new version"
        )
        deposit = zen.new_version(existing["id"])

    deposit = zen.set_metadata(deposit["id"], metadata)
    zen.replace_files(deposit, pdf_path)
    published = zen.publish(deposit["id"])

    record_url = published.get("links", {}).get("record_html") or published.get(
        "links", {}
    ).get("html")
    doi = published.get("doi") or published.get("metadata", {}).get("doi")
    print(f"published: {record_url}")
    print(f"DOI: {doi}")

    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as fh:
            fh.write(f"## Zenodo publish — {deck['title']}\n\n")
            fh.write(f"- Record: <{record_url}>\n")
            fh.write(f"- DOI: `{doi}`\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
