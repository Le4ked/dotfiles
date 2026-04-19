#!/usr/bin/env bash
set -e

PLUGIN_DIR="$(cd "$(dirname "$0")/.config/yazi/plugins/mesh-preview.yazi" && pwd)"

echo "Setting up mesh-preview.yazi venv in $PLUGIN_DIR..."

python3 -m venv "$PLUGIN_DIR/.venv"

"$PLUGIN_DIR/.venv/bin/pip" install --upgrade pip -q

"$PLUGIN_DIR/.venv/bin/pip" install \
    trimesh \
    numpy \
    matplotlib \
    pillow \
    pyrender

echo "Done."
