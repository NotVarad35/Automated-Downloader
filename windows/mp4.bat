@echo off
title Video Downloader (MP4 - H.264)
cd /d "%~dp0"

"%~dp0yt-dlp.exe" ^
  --ffmpeg-location "%~dp0ffmpeg.exe" ^
  --js-runtimes node ^
  -f "bv*[vcodec=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" ^
  --merge-output-format mp4 ^
  --no-write-subs --no-write-auto-subs ^
  -o "%~dp0%%(title)s.%%(ext)s" ^
  -a "%~dp0urls.txt"

pause
