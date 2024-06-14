# Packe installation
tools="wget curl git gh neovim" 
producivity="zoxide fzf entr bat"
scripting="bc termux-api"
customization="neofetch"
languages="nodejs-lts python3 make clang"
cfg packages "$tools" "$producivity" "$scripting" "$customization $languages"
 
# Neovim settings
# LSP's installed with pkg or npm
cfg nvim_lsp_from_pkg "" 
cfg nvim_lsp_from_npm "typescript-language-server" "bash-language-server" "html-lsp"

# Mason is necessary to setup lua files for each LSP
cfg nvim_lsp_from_mason "${nvim_lsp_from_pkg[@]}" "${nvim_lsp_from_npm[@]}"
cfg nvim_treesitter "html" "css" "javascript" "bash" "cpp" "c" "python" "java"  
cfg nvim_lsp "html" "cssls" "tsserver" "bashls" # LSP codenames

# Setup script settings
cfg exclude_setups "" # ex: "neovim.sh font.sh"

# Font Settings 
  # See available fonts at: https://www.nerdfonts.com/font-downloads
cfg font_name "JetBrainsMono"  # "FiraCode" | "Ubunto" | "UbuntoSans" | ....
cfg font_type "Mono"      # "Propo" | "Mono" | ""
cfg font_weight "Bold"    # "Light" | "Regular" | "Medium" | "Retina" | "SemiBold" | "Bold"

# git configs
question "What's your git user name?"
cfg_in git_user_name
question "What's your git email?"
cfg_in git_user_email

cfg git_default_branch "main"

cfg git_aliases \
  "co checkout" \
  "cob 'checkout -B'" \
  "com 'checkout main'" \
  "cm 'commit -m'" \
  "a add" \
  "s status" \
  "p push"

# Symbolic Links
cfg symlinks ""

# Scripts setup
cfg scripts_install_blesh "false" # Ble.sh -> sintax hilighter for bash
cfg scripts_dir "$HOME/scripts"
