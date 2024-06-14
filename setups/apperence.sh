function setup_motd() {
  local motd_path="$HOME/.termux/motd.sh"
  
  if [ ! -e "motd_path" ]; then 
    nodbg touch "$motd_path"
  fi
  
  append_conf "$motd_path" "neofetch"
}

function setup_fullscreen_toggler() {
  local soft="$(asset_path soft-kbd-termux.properties)"
  local hard="$(asset_path physical-kbd-termux.properties)"
  local toggle_path="$(asset_path toggle.sh)"
  local toggle_bin_path="$PREFIX/bin/toggle"
  
  nodbg cp "$soft" "$TERMUX_DIR/termux.properties"
  nodbg cp "$hard" "$TERMUX_DIR/termux.properties-2"
  nodbg cp "$toggle_path" "$toggle_bin_path"
  nodbg chmod 777 "$toggle_bin_path"
  
  question "You can toggle between modes with \e[36mtoggle\e[35m command."
}

nodbg section setup_motd "Termux motd Setup"
nodbg section setup_fullscreen_toggler "Fullscreen toggler Setup"
