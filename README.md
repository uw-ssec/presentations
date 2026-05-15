# UW SSEC Presentations

Public event presentations from the University of Washington Scientific Software Engineering Center (SSEC). Each deck is a self-contained Reveal.js site that is automatically rendered to PDF and deposited to [Zenodo](https://zenodo.org/communities/uw-ssec/) when merged to `main`.

The live gallery is served by GitHub Pages at the repository root (`index.html`); individual decks live in their own directories.

## Repository layout

```
.
├── index.html                    # landing-page gallery
├── <deck-slug>/                  # one directory per presentation
│   ├── index.html                # Reveal.js entry point
│   ├── styles.css                # deck-specific styles (if any)
│   └── zenodo.json               # metadata used by the publish script
└── .github/
    ├── workflows/
    │   └── build-pdf.yml         # PDF build + Zenodo publish workflow
    └── scripts/
        ├── zenodo_publish.py     # publish driver
        └── requirements.txt
```

## Branch model

| Branch    | Zenodo target                  | Purpose                                     |
| --------- | ------------------------------ | ------------------------------------------- |
| `main`    | production (`zenodo.org`)      | Permanent records with real DOIs            |
| `staging` | sandbox (`sandbox.zenodo.org`) | Throwaway records for end-to-end validation |

Day-to-day flow: feature branch → PR to `staging` → review & merge → check the sandbox record → PR `staging` → `main` → production deposit.

Pull requests run the build job (rendering the PDF as an artifact) but never publish, so you can verify the deck looks right before either base branch sees it.

## Adding a new presentation

1. **Create the deck directory** at the repository root using a stable kebab-case slug (this slug appears in the URL and is the unique key for the Zenodo record).
   ```
   <deck-slug>/
     index.html
     styles.css        # if needed
     ...assets
   ```
2. **Add it to the landing gallery** by editing `index.html` (copy an existing `<li class="card">` block and update tags, title, link, and event metadata).
3. **Add `zenodo.json`** next to the deck. Minimum fields:
   ```jsonc
   {
     "slug": "my-deck-slug",
     "community": "uw-ssec",
     "title": "Talk Title",
     "upload_type": "presentation",
     "description": "<p>HTML description shown on the Zenodo record.</p>",
     "creators": [
       {
         "name": "Last, First",
         "affiliation": "University of Washington Scientific Software Engineering Center",
         "orcid": "0000-0000-0000-0000"
       }
     ],
     "keywords": ["topic-1", "topic-2"],
     "license": "cc-by-4.0",
     "pdf": "my-deck-slug.pdf"
   }
   ```
4. **Wire the deck into the workflow.** Open `.github/workflows/build-pdf.yml` and add another build step pointing at the new deck's `index.html`, plus a corresponding publish step (or generalize the existing steps if you're adding several at once).
5. **Open a PR against `staging`.** The PR run will attach the rendered PDF as a workflow artifact you can download from the run page.
6. **Merge to `staging`.** The publish job runs against `sandbox.zenodo.org`. Verify the record looks right.
7. **PR `staging` → `main`.** Merge to produce the real Zenodo record under the [uw-ssec community](https://zenodo.org/communities/uw-ssec/).

## Developing a deck locally

Open the deck's `index.html` in a browser. Most things work from `file://`, but features that fetch (e.g. Reveal's `?print-pdf` mode) need a local server:

```bash
python3 -m http.server 8000
# then open http://localhost:8000/<deck-slug>/
```

To preview the PDF the workflow would produce:

```bash
npx decktape reveal --chrome-arg=--no-sandbox \
  --size 1280x720 --load-pause 500 \
  http://localhost:8000/<deck-slug>/index.html \
  <deck-slug>/<deck-slug>.pdf
```

## Required repository secrets

| Secret                  | Used by branch | Where to generate                                                                  |
| ----------------------- | -------------- | ---------------------------------------------------------------------------------- |
| `ZENODO_TOKEN`          | `main`         | <https://zenodo.org/account/settings/applications/tokens/new/>                     |
| `ZENODO_SANDBOX_TOKEN`  | `staging`      | <https://sandbox.zenodo.org/account/settings/applications/tokens/new/>             |

Both tokens need the `deposit:write` and `deposit:actions` scopes. Sandbox and production Zenodo are independent accounts.

## Versioning and idempotency

The publish script tags each Zenodo record with `version: YYYY.MM.DD` (UTC) at publish time. Re-publishing the same day bumps the suffix (`YYYY.MM.DD.2`, `.3`, …) so versions remain unique. The script finds the existing record for a deck by searching the authenticated user's depositions for a keyword tag of the form `uw-ssec-deck:<slug>` — keep this in mind if you change a deck's slug.

## License

See [`LICENSE`](LICENSE) for the repository license. Each Zenodo record is published under the license declared in its `zenodo.json` (`cc-by-4.0` by default).
