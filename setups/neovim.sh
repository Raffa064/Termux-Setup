function setup_neovim() {
  git clone https://github.com/NvChad/starter ~/.config/nvim

  # Install LSP's
  ensure_installed $nvim_lsp_from_pkg
  if [ "${#nvim_lsp_from_npm[@]}" -gt 1 ]; then 
    eval "npm i -g $nvim_lsp_from_npm"
  fi

  local init_lua_original="$HOME/.config/nvim/lua/plugins/init.lua"
  local init_lua=$(asset_path init.lua)
  local lspconfig_lua="$HOME/.config/nvim/lua/configs/lspconfig.lua"

  rm "$init_lua_original"
  cp "$init_lua" "$init_lua_original"

  local lsp_code_names=$(separate_with_comma "${nvim_lsp_from_mason[@]}")
  local treesitter_langs=$(separate_with_comma "${nvim_treesitter[@]}")
  local servers=$(separate_with_comma "${nvim_lsp[@]}")

  # Inject settings
  replace "%LSP%" "$lsp_code_names" "$init_lua_original"
  replace "%TREESITTER%" "$treesitter_langs" "$init_lua_original"
  sed -i "/local servers = {/s/{[^}]*}/{ ${servers} }/" $lspconfig_lua

  nvim -c "MasonInstallAll"
}

#function old_lsp_setup() {
#  while :; do
#    clear
#    warn "Manual Step Required"
#    echo -e "Please, run \e[36m:TSInstall\e[0m for each language do you want to use:"
#    echo -e "Selected LSP's: \e[33m${dev_lsp[@]}\e[0m"
#    echo -e "Selected Lang. packages: \e[33m${dev_langs[@]}\e[0m"
#    echo
#    echo "Example:"
#    code ":TSInstall javascript java bash python"
#    echo
#    warn "After installation complete, close the editor"
#    question "Type \e[36m'I understand'\e[35m to continue"
#    
#    read confirm
#    if [ "$confirm" == "I understand" ]; then
#      break
#    fi
#  done
#  
#  nvim # First startup and TSInstall
#  
#  local lspconfig="$HOME/.config/nvim/lua/configs/lspconfig.lua"
# 
#  servers=""
#  for s in "${dev_lsp[@]}"; do
#    servers="$servers, \"$s\""
#  done
#  servers=$(echo "$servers" | cut -c 2-)
#  
#  sed -i "/local servers = {/s/{[^}]*}/{ ${servers} }/" $lspconfig
#}

nodbg section setup_neovim "Neovim/NvChad Setup"
