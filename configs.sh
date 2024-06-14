CONFIGS=()

function cfg() {
  local config_name="$1"
  CONFIGS+=("$config_name")
  
  shift
  local config_value=("$@")


  if [ "${#config_value[@]}" -gt 1 ]; then
    eval "$config_name=(${config_value[@]})" # create cffg as var in curr scope
    export -n "$config_name" # Export exactly the same value (array)
  else
    eval "export $config_name=\"${config_value[0]}\""
  fi
}

function cfg_in() {
  local config_name="$1"

  if [ "$DEBUG" == "false" ]; then
    read config_value
  else
    config_value="{debug mode}"
  fi

  cfg "$config_name" "$config_value"
}

import_asset setup-configs.sh
