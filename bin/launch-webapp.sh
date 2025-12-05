#!/usr/bin/env bash

# Always launch Chromium in app mode

url="$1"
shift

# Prefer chromium.desktop, but fallback to the binary if needed
browser="chromium.desktop"

exec_cmd=$(sed -n 's/^Exec=\([^ ]*\).*/\1/p' {~/.local,~/.nix-profile,/usr}/share/applications/$browser 2>/dev/null | head -1)

# If Exec= wasn’t found, fallback to the binary
if [ -z "$exec_cmd" ]; then
    exec_cmd=$(command -v chromium || command -v chromium-browser)
fi

# Final launch in app mode
exec setsid uwsm-app -- "$exec_cmd" --app="$url" "$@"