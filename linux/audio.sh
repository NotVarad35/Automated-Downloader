#!/bin/bash
DIR="$(dirname "$(readlink -f "$0")")"
URLS="$DIR/urls.txt"
source "$DIR/lib.sh"

check_urls "$URLS"

yt-dlp \
  -f bestaudio[ext=webm]/bestaudio \
  -x \
  --write-thumbnail \
  --convert-thumbnails jpg \
  --write-subs --sub-format lrc --convert-subs lrc --write-auto-subs \
  --embed-metadata \
  --exec "ffmpeg -y -i '{}' -i '{}.jpg' -filter_complex '[1:v]crop=min(iw,ih):min(iw,ih)' -map 0 -map 1 -c copy -disposition:v:1 attached_pic '{}.temp' && mv '{}.temp' '{}'" \
  -o '%(title)s - %(uploader)s.%(ext)s' \
  -a "$URLS"

clear_urls "$URLS"
