function zeoxider() {
  local depth="$1"
  local exclude="$2"
  local log="$3"

  if [ $depth -le 0 ]; then
    return
  fi

  for i in $(ls); do
    local path="$(pwd)/$i"
    if [ -d "$path" ] && ! echo "$exclude" | grep $(basename $path) >/dev/null; then
      # zoxide add $path

      if [ "$log" -eq 1 ]; then
        echo "$path"
      fi

      cd $path
      zeoxider "$((--depth))" "$exclude" "$log" # recursive
      cd ..
    else
      if [ -d "$path" ] && [ "$log" -eq 1 ]; then
        echo "excluded dir: $path"
      fi
    fi
  done
}

initial_depth=10
exclude=".git node_modules bin build"
log=0

# get params
while getopts "z:d:l" opt; do 
  case $opt in
    d)
      initial_depth="$OPTARG"
      ;;
    e)
      exclude="$OPTARG"
      ;;
    l)
      log=1
      ;;
    *)
      echo "Invalid option: $opt"
      exit 1
      ;;
  esac
done

zeoxider "$initial_depth" "$exclude" "$log"
