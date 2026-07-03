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
  fi
}

clear_urls() {
  local url_file="$1"
  > "$url_file"
}
