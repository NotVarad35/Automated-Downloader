@echo off
title Video Downloader (MKV - Best Quality)

"%~dp0yt-dlp.exe" ^
  -f bv*+ba/b ^
  --merge-output-format mkv ^
  --no-write-subs --no-write-auto-subs ^
  -o "%%(title)s.%%(ext)s" ^
  -a "%~dp0urls.txt"

pause
