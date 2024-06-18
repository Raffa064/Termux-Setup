# Clear Old Projects

DEBUG="false"

if [ -z "$COP_MAXAGE" ]; then
  COP_MAXAGE="7"
fi

if [ -z "$COP_TRASH" ]; then
  COP_TRASH="$HOME/.cache/cop_trash"
  mkdir -p $COP_TRASH
fi

# Exists and is a Directory
function ed() {
  if [ -e "$1" ] && [ -d "$1" ]; then
    return 0
  fi

  return 1
}

function trash() {
  local dir="$1" 
  local trash_dir="$COP_TRASH$(dirname $dir)"

  echo "Trash: $dir"
  
  if [ "$DEBUG" == "false" ]; then
    if [ ! -e "$trash_dir" ]; then
      mkdir -p $trash_dir
      mv "$dir" "$trash_dir"
    fi
  fi
}

function clean_node() {
  local dir="$1"
  local pjson="$dir/package.json"
  local nmodules="$dir/node_modules"
  
  if [ -e "$pjson" ] && [ -e "$nmodules" ]; then
    trash $nmodules
  fi
}

function clean_java() {
  local dir="$1"
  
  local bin_dirs=(
    "app/build"
    "bin"
    "gdx-game/bin"
    "gdx-game-android/bin"
  )

  for bin in "${bin_dirs[@]}"; do
    bin="$dir/$bin"
    if ed "$bin"; then
      trash "$bin"
    fi
  done
}

function clean_git() {
  local dir="$1"
  local git_repo="$dir/.git"

  if [ -e "$git_repo" ]; then
    git -C "$dir" gc
  fi
}

function clean_project() {
  local dir="$1"

  last_mod=$(find "$dir" -type f -printf '%T@\n' | sort -n | tail -1)

  if [ -z "$last_mod" ]; then
    return # empty folder
  fi

  current_time=$(date +%s)
  time_diff=$(echo "$current_time - $last_mod" | bc)
  
  days=$(echo "$time_diff / 86400" | bc)

  if [ "$days" -gt "$COP_MAXAGE" ]; then
    clean_node "$dir"
    clean_java "$dir"
    clean_git "$dir"
  fi
}

function clean_projects() {
  for dir_name in $(ls); do
    dir="$(pwd)/$dir_name"

    if [ -d "$dir" ]; then
      clean_project "$dir"
    fi
  done

  echo "Found trash: $(du -sh $COP_TRASH)"
  
  rm -rf "$COP_TRASH"
}

clean_projects
