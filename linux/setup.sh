#!/bin/bash
INSTALL_DIR="$HOME/.local/share/automated-downloader"
BIN_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

mkdir -p "$INSTALL_DIR" "$BIN_DIR"

cp "$SCRIPT_DIR"/*.sh "$SCRIPT_DIR/urls.txt" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR"/*.sh

ln -sf "$INSTALL_DIR/audio.sh" "$BIN_DIR/audio"
ln -sf "$INSTALL_DIR/video.sh" "$BIN_DIR/video"
ln -sf "$INSTALL_DIR/mp4.sh" "$BIN_DIR/mp4"

echo "Installed to $INSTALL_DIR"
echo "Symlinks created in $BIN_DIR"
echo ""
echo "Usage from anywhere:"
echo "  audio    — OPUS audio download"
echo "  video    — Best quality MKV download"
echo "  mp4      — Compatible MP4 download"
echo ""
echo "Make sure $BIN_DIR is in your PATH:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
