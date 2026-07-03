# Automated Media Workflow Tool (yt-dlp)

A lightweight, automated pipeline designed to streamline the extraction and downloading of high-fidelity audio and video media.

## 🎯 The Objective

Manually entering command-line arguments for repetitive media downloads is inefficient and prone to syntax errors. This project solves that bottleneck by providing pre-configured scripts that interface directly with `yt-dlp`. It allows for bulk processing by reading multiple links from a single text file, executing complex formatting arguments with a single command.

**Windows users** use `.bat` files. **Linux / macOS users** use `.sh` files.

---

## ✨ Features

* **Batch Processing:** Ingests multiple URLs simultaneously from `urls.txt`.
* **Audio Automation (`audio.bat` / `audio.sh`):**
    * Downloads the best available OPUS stream — no re-encode, original quality preserved.
    * Square-crops cover art via ffmpeg and embeds it into the file.
    * Downloads `.lrc` synced lyrics alongside the audio (if available on YouTube).
    * Writes metadata (title, uploader, etc.) to the file.
    * Saves as `Title - Artist.webm`.
* **Video Automation — Best Quality (`video.bat` / `video.sh`):**
    * Downloads the highest quality video stream available (AV1 > VP9 > H.264) with the best audio stream.
    * Merges into an `.mkv` container — no codec restrictions, maximum quality per file size.
* **Video Automation — Compatible (`mp4.bat` / `mp4.sh`):**
    * Targets H.264 (AVC1) video with AAC audio, merged into an `.mp4` container.
    * Widely compatible with video editors, Windows Media Player, and mobile devices.

---

## 🪟 Windows

### Prerequisites

1. **yt-dlp** — Download `yt-dlp.exe` from the [official releases page](https://github.com/yt-dlp/yt-dlp/releases) and place it in the `windows/` folder.
2. **ffmpeg** — Required for square cover art cropping. Download from the [official builds page](https://www.gyani.dev/ffmpeg/builds/) and place `ffmpeg.exe` in the `windows/` folder, or add it to your `PATH`.

All scripts use `%~dp0yt-dlp.exe` — they look for `yt-dlp.exe` in their own directory, making the folder fully self-contained.

### Usage

1. Open `windows/urls.txt` and paste the links (one per line). Save and close.
2. Double-click the script you need:

| Script | Format | Best for |
|---|---|---|
| `audio.bat` | `.webm` (OPUS) | Music listening, highest quality audio |
| `video.bat` | `.mkv` (AV1/VP9/OPUS) | Archiving, maximum quality per file size |
| `mp4.bat` | `.mp4` (H.264/AAC) | Editing, sharing, wide compatibility |

Files are saved in the same directory as the scripts.

---

## 🐧 Linux / 🍎 macOS

### Prerequisites

```bash
# Arch Linux
sudo pacman -S yt-dlp ffmpeg

# Debian / Ubuntu
sudo apt install yt-dlp ffmpeg

# macOS (Homebrew)
brew install yt-dlp ffmpeg

# Fedora
sudo dnf install yt-dlp ffmpeg
```

### Usage

```bash
cd linux/
./audio.sh      # Audio download
./video.sh      # Best quality video (MKV)
./mp4.sh        # Compatible video (MP4)
```

If `urls.txt` is empty when you run a script, it will automatically open your preferred editor:

1. **`$VISUAL`** — used if set
2. **`$EDITOR`** — fallback if set
3. **Terminal + editor** — detects your terminal (foot, kitty, ghostty, alacritty, wezterm, gnome-terminal, konsole, xterm) and editor (nvim, vim, vi, nano, micro)
4. **`xdg-open`** — last resort, opens in GUI default editor

Paste your URLs, save and close — the script picks up from there. After downloads finish, `urls.txt` is cleared automatically.

### Install to `$PATH` (optional)

Run `setup.sh` to install the scripts system-wide so you can use them from any folder:

```bash
cd linux/
./setup.sh
```

This copies all files to `~/.local/share/automated-downloader/` and creates symlinks in `~/.local/bin/`. Make sure `~/.local/bin` is in your `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"    # add to ~/.bashrc or ~/.zshrc
```

Then use from anywhere:

```bash
audio      # or
video      # or
mp4
```

### macOS notes

- The `--exec` ffmpeg command for square cover art works on macOS if ffmpeg is installed via `brew`.
- Terminal detection includes `Terminal.app` and `iTerm2`.

---

## 🧠 How it works

### audio — OPUS + Square Cover Art + Lyrics
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

### video — Highest Quality MKV
```
yt-dlp -f bv*+ba/b                   ← Best video + best audio (any codec)
  --merge-output-format mkv          ← MKV container (no restrictions)
  -o "%(title)s.%(ext)s"
```

### mp4 — Compatible H.264 MP4
```
yt-dlp -f "bv*[vcodec=avc1][ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best"
                                     ← Best H.264 video + AAC audio in MP4
  --merge-output-format mp4
  -o "%(title)s.%(ext)s"
```

---

## 📁 File structure

```
Automated-Downloader/
├── windows/
│   ├── audio.bat      → OPUS audio + square cover art + lyrics
│   ├── video.bat      → Best quality MKV (AV1/VP9)
│   ├── mp4.bat        → Compatible MP4 (H.264)
│   ├── urls.txt       → Paste URLs here (one per line)
│   ├── yt-dlp.exe     → yt-dlp binary (place here)
│   └── ffmpeg.exe     → ffmpeg binary (place here, for cover art)
│
├── linux/
│   ├── audio.sh       → OPUS audio + square cover art + lyrics
│   ├── video.sh       → Best quality MKV (AV1/VP9)
│   ├── mp4.sh         → Compatible MP4 (H.264)
│   ├── lib.sh         → Shared functions (editor detection, etc.)
│   ├── urls.txt       → Paste URLs here (one per line)
│   └── setup.sh       → Install to ~/.local/bin for system-wide use
│
├── LICENSE
└── README.md
```

---

## ⚠️ Troubleshooting & Customization

These scripts serve as my personal presets for workflow efficiency. They rely on the core functionality of the `yt-dlp` project.

If you want to modify the core arguments, or if you encounter specific download errors, site-specific breakages, or issues directly related to the executable, please refer to the official documentation and issue tracker:
* **[Official yt-dlp GitHub Repository](https://github.com/yt-dlp/yt-dlp)**
