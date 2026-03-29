@echo off

"C:\yt-dlp\yt-dlp.exe" ^
 -f "bv*[vcodec^=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" ^
 --merge-output-format mp4 ^
 --audio-quality 0 ^
 --no-write-subs ^
 --no-write-auto-subs ^
 -a urls.txt

pause
