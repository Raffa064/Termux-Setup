function run_setups() {
  for setup in $(ls ./setups); do
    if ! echo $exclude_setups | grep $setup >/dev/null 2>&1; then
      source "./setups/${setup}"
    fi
  done
}
