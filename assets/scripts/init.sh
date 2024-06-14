# Init zoxide
eval "$(zoxide init --cmd cd bash)"

# Ctrl+r history search
function fzf_history() {
  local selected=$(history | fzf --tac +s +m -e --ansi)
  READLINE_LINE=$(echo $selected | sed -E 's/ *[0-9]+\*? *//')
  READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": fzf_history'
