"""Serve the repository root for local deck previews, backing off to the next
free port when the requested one is taken. Run it as `pixi run serve [port]`.
"""

import functools
import socket
import sys
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

HOST = "127.0.0.1"
ATTEMPTS = 10  # the requested port plus nine backups above it
ROOT = Path(__file__).resolve().parent.parent
DECK_PATH = "from-hand-coding-to-ai-orchestration/build/"


def in_use(port: int) -> bool:
    # Probe with a connect as well as relying on bind: macOS lets a
    # SO_REUSEADDR bind on 127.0.0.1 succeed while another process listens on
    # 0.0.0.0, which would silently shadow that server.
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as probe:
        probe.settimeout(0.2)
        return probe.connect_ex((HOST, port)) == 0


def main() -> int:
    # Flush each line so the chosen URL shows up even when output is piped.
    sys.stdout.reconfigure(line_buffering=True)
    requested = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    handler = functools.partial(SimpleHTTPRequestHandler, directory=str(ROOT))

    for port in range(requested, requested + ATTEMPTS):
        if in_use(port):
            print(f"Port {port} is in use, trying {port + 1}...")
            continue
        try:
            httpd = ThreadingHTTPServer((HOST, port), handler)
        except OSError:
            print(f"Port {port} is in use, trying {port + 1}...")
            continue
        with httpd:
            print(f"Serving {ROOT} at http://localhost:{port}/")
            print(f"Deck: http://localhost:{port}/{DECK_PATH}")
            print("Press Ctrl+C to stop.")
            try:
                httpd.serve_forever()
            except KeyboardInterrupt:
                print("\nStopped.")
        return 0

    last = requested + ATTEMPTS - 1
    print(f"Ports {requested}-{last} are all in use. Pass another: pixi run serve <port>")
    return 1


if __name__ == "__main__":
    sys.exit(main())
