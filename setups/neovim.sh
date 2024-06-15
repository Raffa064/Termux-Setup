function setup_neovim() {
  local nvim_dir="$HOME/.config/nvim/"
  local nvim_git_repo="$nvim_dir/.git"

  if [ -e "$nvim_git_repo" ]; then
    add "Nvim is already setuped"
    return
  fi

  git clone https://github.com/NvChad/starter ~/.config/nvim

  # Install LSP's
  ensure_installed $nvim_lsp_from_pkg
  if [ "${#nvim_lsp_from_npm[@]}" -gt 1 ]; then 
    eval "npm i -g $nvim_lsp_from_npm"
  fi

  local init_lua=$(asset_path init.lua)
  local init_lua_original="$nvim_dir/lua/plugins/init.lua"
  local lspconfig_lua="$nvim_dir/lua/configs/lspconfig.lua"

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

section setup_neovim "Neovim/NvChad Setup"
