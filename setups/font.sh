function setup_font() {
  while :; do
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$font_name.zip"
  
    add "Installing Font: $font_name"
    if wget -c "$font_url" > /dev/null 2>&1; then
      unzip "$font_name.zip" -d "$font_name"
      local font_file="${font_name}/${font_name}NerdFont${font_type}-${font_weight}.ttf"
      
      local termux_font_path="$TERMUX_DIR/font.ttf"
      if [ -e "$termux_font_path" ]; then
        question "Replacing old font"
        mv "$termux_font_path" "$TERMUX_DIR/old-font-$RANDOM.ttf"
      fi
      
      mv "$font_file" "$termux_font_path"
      rm -rf "$font_name/" "$font_name.zip"
      termux-reload-settings
      
      add "Font successfully applied!"
      
      break
    else
      err "Invalid font settings..."
      warn "'../assets/font.configs' must be fixed manually."
      sleep 2
      editor_open $(asset_path font.configs)
    fi
  done
}

nodbg section setup_font "Font Setup"
