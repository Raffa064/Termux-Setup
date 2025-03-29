function setup_motd() {
  local motd_path="$HOME/.termux/motd.sh"
  
  if [ -e "motd_path" ]; then
    warn "Overriding motd.sh"
    nodbg cp "$motd_path" "$motd_path.bkp"
    nodbg rm "$motd_path"
  fi
  
  #append_conf "$motd_path" "neofetch"

  local motd="$(asset_path motd.sh)"
  nodbg cp "$motd" "$motd_path" 
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

function setup_colors() {
  local color_props_path=$(asset_path colors.properties)
  nodbg cp "$color_props_path" "$TERMUX_DIR/colors.properties"
  nodbg termux-reload-settings
}

nodbg section setup_motd "Termux motd Setup"
nodbg section setup_fullscreen_toggler "Fullscreen toggler Setup"
nodbg section setup_colors "Termux colors Setup"
