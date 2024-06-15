# Utility functions

EDITOR="nano"
EDITOR_ARGS="-l"
TERMUX_DIR="$HOME/.termux"

function nodbg() {
  if [ "$DEBUG" == "false" ]; then 
    eval "$@"
  fi
}

function ondbg() {
  if [ "$DEBUG" == "true" ]; then
    eval "$@"
  fi
}

function highlight() {
  local color_code="$1"
  shift 1
  local content="$@"
  
  echo -e "${color_code}${content}\e[0m"
}

function header() {
  highlight "\e[33m" "[*] $@"
}

function question() {
  highlight "\e[35m" "[?] $@"
}

function add() {
  highlight "\e[32m" "[+] $@"
}

function remove() {
  highlight "\e[31m" "[-] $@"
}

function warn() {
  highlight "\e[1;33m" "[!] $@"
}

function err() {
  highlight "\e[1;31m" "[x] $@"
}

function code() {
  highlight "\e[1;32m" "[$] $@"
}

function update_and_upgrade {
  nodbg 'eval "yes | pkg update -y && yes | pkg upgrade -y"'
}

function install_pkg {
  local pkg="$1"
  if [ "$DEBUG" == "false" ]; then
    if pkg install $pkg -y > /dev/null 2>&1; then
      add "$pkg installed successfuly"
    else
      err "Error while installing '$pkg'"
    fi
  fi
}

function ensure_installed {
  for pkg in "${@}"; do
    if command -v "$pkg" >/dev/null 2>&1 || apt list --installed 2>/dev/null | grep -q "^$pkg/"; then
      warn "Already installed '$pkg'"
    else
      local dbg_prefix=""

      ondbg "dbg_prefix=\"\e[36m(DBG)\e[32m \""

      add "${dbg_prefix}Installing '$pkg'..."
      install_pkg $pkg
    fi
  done
}

function bell() {
  local repetitions="$1"
  local delay="$2"

  if [ -z "$delay" ]; then
    delay=0.1
  fi

  for (( c=0; c<$repetitions; c++ ))
  do
    echo -n -e "\a"
    sleep "$delay";
  done
}

function asset_path {
  local file_name="$1"

  echo "./assets/$file_name"
}

function get_asset {
  local file_name="$1";
  local file_path="$(asset_path $file_name)"
  local content="$(cat $file_path)";

  echo -e "$content"
}

shopt -s expand_aliases
alias import_asset="source import-asset.sh"

function editor_open {
  local file_name="$1";
  eval "$EDITOR $EDITOR_ARGS $file_name"
}

function section() {
  local section_name="$1"
  local section_title="$2"

  header "$section_title"
  eval "$section_name"
}

function separate_with_comma() {
  local items=("$@")
  local result=""
  
  for s in "${items[@]}"; do
    result="$result, \"$s\""
  done

  result=$(echo "$result" | cut -c 2-)

  echo "$result"
}

function replace() {
  local pattern="$1"
  local replace_text="$2"
  local file_path="$3"

  sed -i "s/$pattern/$replace_text/" "$file_path"

  ondbg warn "Mutable function call in debug mode: replace"
}

# Append configuration lines if not already in
function append_conf() {
  local file="$1"
  local conf="$2"

  if ! cat $file | grep "$conf" >/dev/null; then
    echo "$conf" >> "$file"
  fi

  ondbg warn "Mutable function call in debug mode: append_conf"
}

function mv() {
  err "Don't use mv inside setup scripts!!"
  exit
}

if [ "$1" == "--no-dbg" ]; then
  DEBUG="false"
else
  DEBUG="true"
  warn "[ Debug Mode Enabled ]"
fi
