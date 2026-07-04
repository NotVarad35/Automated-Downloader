#!/bin/bash

detect_terminal() {
  if [ -n "$TERMINAL" ]; then
    echo "$TERMINAL"
    return
  fi
  for t in foot kitty ghostty alacritty wezterm gnome-terminal konsole xterm; do
    command -v "$t" &>/dev/null && echo "$t" && return
  done
}

detect_editor() {
  for ed in nvim vim vi nano micro; do
    command -v "$ed" &>/dev/null && echo "$ed" && return
  done
}

check_urls() {
  local url_file="$1"

  if [ ! -s "$url_file" ]; then
    if [ -t 0 ]; then
      if [ -n "$VISUAL" ]; then
        $VISUAL "$url_file"
      elif [ -n "$EDITOR" ]; then
        $EDITOR "$url_file"
      else
        local term
        term=$(detect_terminal)
        if [ -n "$term" ]; then
          local editor
          editor=$(detect_editor)
          if [ -n "$editor" ]; then
            $term -e "$editor" "$url_file"
          else
            xdg-open "$url_file" &>/dev/null
            echo "Opened urls.txt in default editor. Press Enter after saving and closing..."
            read -r
          fi
        else
          xdg-open "$url_file" &>/dev/null
          echo "Opened urls.txt in default editor. Press Enter after saving and closing..."
          read -r
        fi
      fi

      if [ ! -s "$url_file" ]; then
        echo "urls.txt is still empty. Aborting."
        exit 1
      fi
    else
      xdg-open "$url_file" &>/dev/null
      notify-send "urls.txt is empty" "もっともっともっともっとちゃんと言って"
      exit 1
    fi
  fi
}

clear_urls() {
  local url_file="$1"
  > "$url_file"
}

notify_done() {
  local type="$1"
  case "$type" in
    audio)
      local msgs=(
        "🎵 YOUR PLAYLIST IS COOKING RN 🔥"
        "downloaded: peak. now streaming: also peak."
        "JPOP download complete. Your culture is expanding 📈"
        "MUSIXX just added"
        "loading 1s and 0s in order"
        "since buying isnt owning, then pirating isnt stealing, and u made the right choice, just support them in other ways"
        "SENPAI, MUSIC ARE ready ✨"
        "Onii-chan, Gohan ni suru? Ofuro ni suru? Soretomo wa-ta-shi????"
        "🎧 That Ado vocal just hit different. Good choice fr fr."
        "🎌 The weeb-to-OPUS pipeline is working flawlessly."
        "🐧 Brought to you by the Linux kernel and your questionable life choices."
        "⚡ Exit code 0. Errors 0. Bad decisions: infinite."
        "📊 Bandwidth spent. Storage filled. Taste: immaculate."
        "🔒 01001001 01110100 00100000 01110011 01101100 01100001 01110000 01110011"
        "🤖 Beep boop. Download successful. Human approval not required."
        "🔥 CPU: 🔥🔥🔥. Music taste: ❄️❄️❄️. Worth it."
        "📡 Download complete. The internet police are on their way. Better luck next time."
      )
      ;;
    video)
      local msgs=(
        "ITS TIME TO WATCH PEAK"
        "ABsoLUTE CINEMA ✋"
        "Download complete. Your storage is crying but idc."
        "loading 1s and 0s in order"
        "since buying isnt owning, then pirating isnt stealing, and u made the right choice, just support them in other ways"
        "SENPAI, VIDEOS ARE ready ✨"
        "Onii-chan, Gohan ni suru? Ofuro ni suru? Soretomo wa-ta-shi????"
        "📡 Downloaded bytes. Arranged pixels. You're welcome."
        "🎞️ This file is POV: you have impeccable taste."
        "Sekiro? Elden Ring? or just an anime? either way W."
        "🐧 Brought to you by the Linux kernel and your questionable life choices."
        "⚡ Exit code 0. Errors 0. Bad decisions: infinite."
        "📊 Bandwidth spent. Storage filled. Taste: immaculate."
        "🔒 01001001 01110100 00100000 01110011 01101100 01100001 01110000 01110011"
        "🤖 Beep boop. Download successful. Human approval not required."
        "🔥 CPU: 🔥🔥🔥. Music taste: ❄️❄️❄️. Worth it."
        "📡 Download complete. The internet police are on their way. Better luck next time."
      )
      ;;
    mp4)
      local msgs=(
        "DaVinci. Premiere. Any editor. This file is ready."
        "Saved in MP4 because you have standards and an editor."
        "🔧 Downloaded. Remuxed. Ready. That's what she said."
        "ITS TIME TO WATCH PEAK"
        "ABsoLUTE CINEMA ✋"
        "loading 1s and 0s in order"
        "since buying isnt owning, then pirating isnt stealing, and u made the right choice, just support them in other ways"
        "SENPAI, VIDEOS ARE ready ✨"
        "🐧 Brought to you by the Linux kernel and your questionable life choices."
        "⚡ Exit code 0. Errors 0. Bad decisions: infinite."
        "📊 Bandwidth spent. Storage filled. Taste: immaculate."
        "🔒 01001001 01110100 00100000 01110011 01101100 01100001 01110000 01110011"
        "🤖 Beep boop. Download successful. Human approval not required."
        "🔥 CPU: 🔥🔥🔥. Music taste: ❄️❄️❄️. Worth it."
        "📡 Download complete. The internet police are on their way. Better luck next time."
      )
      ;;
  esac
  local idx=$((RANDOM % ${#msgs[@]}))
  notify-send "Download Complete" "${msgs[$idx]}"
}
