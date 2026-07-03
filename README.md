# Automated Media Workflow Tool (yt-dlp)

A lightweight, automated pipeline designed to streamline the extraction and downloading of high-fidelity audio and video media.

## 🎯 The Objective

Manually entering command-line arguments for repetitive media downloads is inefficient and prone to syntax errors. This project solves that bottleneck by providing pre-configured Windows Batch (`.bat`) scripts that interface directly with `yt-dlp`. It allows for bulk processing by reading multiple links from a single text file, executing complex formatting arguments with a single click.

## ✨ Features

* **Batch Processing:** Ingests multiple URLs simultaneously from `urls.txt`.
* **Audio Automation (`audio.bat`):**
    * Downloads the best available OPUS stream — no re-encode, original quality preserved.
    * Square-crops cover art via ffmpeg and embeds it into the file.
    * Downloads `.lrc` synced lyrics alongside the audio (if available on YouTube).
    * Writes metadata (title, uploader, etc.) to the file.
    * Saves as `Title - Artist.webm`.
* **Video Automation — Best Quality (`video.bat`):**
    * Downloads the highest quality video stream available (AV1 > VP9 > H.264) with the best audio stream.
    * Merges into an `.mkv` container — no codec restrictions, maximum quality per file size.
* **Video Automation — Compatible (`mp4.bat`):**
    * Targets H.264 (AVC1) video with AAC audio, merged into an `.mp4` container.
    * Widely compatible with video editors, Windows Media Player, and mobile devices.

## ⚙️ Prerequisites

### 1. yt-dlp
Download the latest `yt-dlp.exe` from the [official releases page](https://github.com/yt-dlp/yt-dlp/releases) and place it in the same folder as the `.bat` files.

### 2. ffmpeg (required for audio cover art)
`audio.bat` uses ffmpeg to crop the thumbnail to a square and embed it. Download from the [official ffmpeg builds page](https://www.gyani.dev/ffmpeg/builds/) and place `ffmpeg.exe` in the same folder, or add it to your system PATH.

All scripts use `%~dp0yt-dlp.exe` — they look for `yt-dlp.exe` in their own directory, making the folder fully self-contained.

## 🚀 Usage

1. Open `urls.txt` and paste the links to the media you want to download (one URL per line). Save and close the file.
2. Double-click the script that matches your need:

| Script | Format | Best for |
|---|---|---|
| `audio.bat` | `.webm` (OPUS) | Music listening, highest quality audio |
| `video.bat` | `.mkv` (AV1/VP9/OPUS) | Archiving, maximum quality per file size |
| `mp4.bat` | `.mp4` (H.264/AAC) | Editing, sharing, wide compatibility |

3. Files are saved in the same directory as the scripts.

## 🧠 How it works

### audio.bat — OPUS + Square Cover Art + Lyrics
```
yt-dlp -f bestaudio[ext=webm]       ← OPUS stream, no re-encode
  --write-thumbnail                  ← Save thumbnail
  --convert-thumbnails jpg           ← Force JPG format
  --write-subs --sub-format lrc      ← Download synced lyrics (.lrc)
  --convert-subs lrc
  --write-auto-subs                  ← Auto-generated subs if no manual
  --embed-metadata                   ← Title, uploader, etc.
  --exec "ffmpeg ... crop square ... embed ..."  ← Post-process cover art
  -o "%(title)s - %(uploader)s.%(ext)s"
```

### video.bat — Highest Quality MKV
```
yt-dlp -f bv*+ba/b                   ← Best video + best audio (any codec)
  --merge-output-format mkv          ← MKV container (no restrictions)
  -o "%(title)s.%(ext)s"
```

### mp4.bat — Compatible H.264 MP4
```
yt-dlp -f "bv*[vcodec=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best"
                                     ← Best H.264 video + AAC audio in MP4
  --merge-output-format mp4
  -o "%(title)s.%(ext)s"
```

## 📁 File structure
```
Automated-Downloader/
├── audio.bat          → OPUS audio + square cover art + lyrics
├── video.bat          → Best quality MKV (AV1/VP9)
├── mp4.bat            → Compatible MP4 (H.264)
├── urls.txt           → Paste URLs here (one per line)
├── yt-dlp.exe         → yt-dlp binary (place here)
└── ffmpeg.exe         → ffmpeg binary (place here, for cover art)
```

## ⚠️ Troubleshooting & Customization

These scripts serve as my personal presets for workflow efficiency. They rely on the core functionality of the `yt-dlp` project.

If you want to modify the core arguments, or if you encounter specific download errors, site-specific breakages, or issues directly related to the executable, please refer to the official documentation and issue tracker:
* **[Official yt-dlp GitHub Repository](https://github.com/yt-dlp/yt-dlp)**
