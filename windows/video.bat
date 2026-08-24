@echo off
title Video Downloader (MKV - Best Quality)
cd /d "%~dp0"

"%~dp0yt-dlp.exe" ^
  --ffmpeg-location "%~dp0ffmpeg.exe" ^
  --js-runtimes node ^
  -f bv*+ba/b ^
  --merge-output-format mkv ^
  --no-write-subs --no-write-auto-subs ^
  -o "%~dp0%%(title)s.%%(ext)s" ^
  -a "%~dp0urls.txt"

pause
