@echo off

"C:\yt-dlp\yt-dlp.exe" ^
  -x ^
  --audio-format mp3 ^
  --audio-quality 0 ^
  --embed-thumbnail ^
  --add-metadata ^
  --no-write-subs ^
  --no-write-auto-subs ^
  -o "%%(title)s.%%(ext)s" ^
  -a urls.txt

pause