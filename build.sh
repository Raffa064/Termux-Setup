#!/bin/sh

clear

source "./utils.sh"
source "./configs.sh"
source "./install-packages.sh"
source "./run-setups.sh"

function pconf() {
  local config="$1"
  eval value="\${$config[@]}"

  if [ -z "$value" ]; then
    value="\e[33mnone\e[37m"
  fi

  echo -e "\e[32m$config \e[36m=\e[37m $value"
}

function print_configs() {
  for conf in "${CONFIGS[@]}"; do
    pconf $conf
  done
}

function confirm_configs() {
  while :; do
    clear
    header "Confir your configs:"
    
    print_configs
    
    warn "Here are all the current configurations."
    question "Is everything correct, or would you like to change anything? (Y/n)"
    
    nodbg read option

    if [ "$option" == "Y" ] || [ "$DEBUG" == "true" ]; then
      break;
    else
      if [ "$option" == "n" ]; then
        editor_open ./configs.sh
      else
        err "Invalid option: \e[36mY\e[1;31m to confirm or \e[36mn\e[1;31m to edit configs"
        sleep 2
      fi
    fi

    clear
  done
}

confirm_configs 

section update_and_upgrade "Updating packages..."
section install_packages "Installing packages..."
section run_setups "Running setups..."

append_conf "test.sh" "echo hello world"
