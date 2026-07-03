#!/bin/bash
DIR="$(dirname "$(readlink -f "$0")")"
URLS="$DIR/urls.txt"
source "$DIR/lib.sh"

check_urls "$URLS"

yt-dlp \
  -f 'bv*[vcodec=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best' \
  --merge-output-format mp4 \
  --no-write-subs --no-write-auto-subs \
  -o '%(title)s.%(ext)s' \
  -a "$URLS"

clear_urls "$URLS"
