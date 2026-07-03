@echo off
title Audio Downloader

"%~dp0yt-dlp.exe" ^
  -f bestaudio[ext=webm]/bestaudio ^
  -x ^
  --write-thumbnail ^
  --convert-thumbnails jpg ^
  --write-subs --sub-format lrc --convert-subs lrc --write-auto-subs ^
  --embed-metadata ^
  --exec "ffmpeg -y -i \"{}\" -i \"{}.jpg\" -filter_complex \"[1:v]crop=min(iw,ih):min(iw,ih)\" -map 0 -map 1 -c copy -disposition:v:1 attached_pic \"{}.temp\" && move /Y \"{}.temp\" \"{}\"" ^
  -o "%%(title)s - %%(uploader)s.%%(ext)s" ^
  -a urls.txt

pause
