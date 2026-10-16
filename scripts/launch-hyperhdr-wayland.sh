#!/usr/bin/env bash
set -euo pipefail

# Launcher for HyperHDR on Linux Wayland environments using PipeWire hardware capture.

HYPERHDR_BIN="${HOME}/hyperhdr/bin/hyperhdr"

if [ ! -f "$HYPERHDR_BIN" ]; then
    if command -v hyperhdr >/dev/null 2>&1; then
        HYPERHDR_BIN="$(command -v hyperhdr)"
    else
        echo "Error: hyperhdr binary not found at $HYPERHDR_BIN or in system PATH." >&2
        exit 1
    fi
fi

echo "==> Launching HyperHDR with PipeWire capture..."
exec "$HYPERHDR_BIN" --pipewire --service
