#!/bin/bash
DIR="$(dirname "$(readlink -f "$0")")"
URLS="$DIR/urls.txt"
source "$DIR/lib.sh"

check_urls "$URLS"

yt-dlp \
  -f bv*+ba/b \
  --merge-output-format mkv \
  --no-write-subs --no-write-auto-subs \
  -o '%(title)s.%(ext)s' \
  -a "$URLS"

clear_urls "$URLS"
