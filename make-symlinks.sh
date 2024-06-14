function make_symlinks() {  
  for sym in "${symlinks[@]}"; do
    from="${sym[0]}"
    to="${sym[1]}"
    nodbg ln -s $from $to
  done
}
