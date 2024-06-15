INIT_LINES=()

function setup_scripts() {
  # Copy scripts dir
  local scripts="$(asset_path scripts)"
  cp -r $scripts $scripts_dir
}

function setup_ble() {
  if [ "$scripts_install_blesh" != "true" ]; then
    question "Ble.sh installation skipped"
    return
  fi

  # Install ble.sh project
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git .blesh

  # Compile ble.sh to ./local
  make -C .blesh install PREFIX=~/.local

  # Add to init
  INIT_LINES+=("USER='$git_user_name'") # prevent ble.sh dialog
  INIT_LINES+=('source ~/.local/share/blesh/ble.sh')

  rm -rf .blesh

  local blerc=$(asset_path .blerc)
  cp $blerc "$HOME"
}

function setup_init_sh() {
  local bashrc="$PREFIX/etc/bash.bashrc"
  local init_sh="$scripts_dir/init.sh"

  append_conf "$bashrc" "source $init_sh"

  INIT_LINES+=( "source $scripts_dir/autoalias.sh $scripts_dir" )
  
  for init_line in "${INIT_LINES[@]}"; do
    append_conf "$init_sh" "$init_line"
  done
}

nodbg section setup_scripts "Scripts Setup"
nodbg section setup_ble "Ble.sh Setup"
nodbg section setup_init_sh "Init.sh Setup"
