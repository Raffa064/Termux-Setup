function setup_git() {
  echo "Checkout your git configs:"
  echo "User name: $git_user_name"
  echo "User email: $git_user_email"
  echo "Default branch: $git_default_branch"

  echo "Confirm? (Y/n)"

  read answer

  if [ "$answer" != "Y" ]; then
    editor_open $(asset_path "git.configs")
    setup_git
    return
  fi

  git config --global user.name "$git_user_name"
  git config --global user.email "$git_user_email"
  git config --global init.defaultBranch "$git_default_branch"

  for alias in "${git_aliases[@]}"; do
    echo "[+] Git alias: '$alias'"
    eval "git config --global alias.$alias"
  done

  git config --global --add safe.directory "*" # Fix safe dir issues
}

function setup_gh() {
  gh auth login -p https --web
}

nodbg section setup_git "Git Setup"
nodbg section setup_gh "GitHub CLI Setup"
