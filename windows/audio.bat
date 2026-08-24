@echo off
title Audio Downloader
cd /d "%~dp0"

"%~dp0yt-dlp.exe" ^
  --ffmpeg-location "%~dp0ffmpeg.exe" ^
  --js-runtimes node ^
  -f bestaudio[ext=webm]/bestaudio ^
  -x ^
  --write-subs --sub-format lrc --convert-subs lrc --write-auto-subs ^
  --embed-thumbnail ^
  --embed-metadata ^
  -o "%~dp0%%(title)s - %%(uploader)s.%%(ext)s" ^
  -a "%~dp0urls.txt"

pause

