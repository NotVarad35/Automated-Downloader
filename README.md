# Automated Media Workflow Tool (yt-dlp)

A lightweight, automated pipeline designed to streamline the extraction and downloading of high-fidelity audio and video media. 

## 🎯 The Objective
Manually entering command-line arguments for repetitive media downloads is inefficient and prone to syntax errors. This project solves that bottleneck by providing pre-configured Windows Batch (`.bat`) scripts that interface directly with `yt-dlp`. It allows for bulk processing by reading multiple links from a single text file, executing complex formatting arguments with a single click.

## ✨ Features

* **Batch Processing:** Ingests multiple URLs simultaneously from `urls.txt`.
* **Audio Automation (`audio.bat`):** * Automatically extracts audio and converts it to the highest quality MP3 (`--audio-quality 0`).
    * Automatically embeds the source thumbnail and writes metadata to the file.
    * Bypasses unnecessary subtitle downloads to save bandwidth.
* **Video Automation (`video.bat`):**
    * Targets the highly compatible AVC1 codec (H.264) for video and M4A for audio, seamlessly merging them into an `.mp4` container.
    * Ensures the best possible audio quality is paired with the video.

## ⚙️ Setup & Installation

1.  **Download yt-dlp:** You must have the official `yt-dlp.exe` downloaded.
2.  **Directory Setup:** By default, these scripts are configured to look for the executable in the `C:\yt-dlp\` directory. 
    * *Note: If you place `yt-dlp.exe` in a different folder, you must edit the `.bat` files to reflect your custom path.*
3.  **Clone this repository:** Place `audio.bat`, `video.bat`, and `urls.txt` in your desired working folder.

## 🚀 Usage

1. Open `urls.txt` and paste the links to the media you want to download (one URL per line). Save and close the file.
2. Double-click either `audio.bat` or `video.bat` depending on your needs.
3. The script will execute, download the files into the same directory, and automatically apply all formatting parameters.

## ⚠️ Troubleshooting & Customization

These scripts serve as my personal presets for workflow efficiency. They rely on the core functionality of the `yt-dlp` project. 

If you want to modify the core arguments, or if you encounter specific download errors, site-specific breakages, or issues directly related to the executable, please refer to the official documentation and issue tracker:
* **[Official yt-dlp GitHub Repository](https://github.com/yt-dlp/yt-dlp)**
