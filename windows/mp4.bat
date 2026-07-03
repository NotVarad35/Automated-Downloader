@echo off
title Video Downloader (MP4 - H.264)

"%~dp0yt-dlp.exe" ^
  -f "bv*[vcodec=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" ^
  --merge-output-format mp4 ^
  --no-write-subs --no-write-auto-subs ^
  -o "%%(title)s.%%(ext)s" ^
  -a "%~dp0urls.txt"

pause
