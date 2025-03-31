# If fzf is not installed, install it
ensure_package fzf -s

fzf --fish | source

set -Ux FZF_DEFAULT_OPTS " \
--color=bg+:#313244,bg:#1e1e2e,spinner:#b4befe,hl:#cba6f7 \
--color=fg:#cdd6f4,header:#cba6f7,info:#cba6f7,pointer:#b4befe \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#cba6f7 \
--color=border:#cba6f7,label:#cba6f7 \
--border rounded \
--multi"

# Fish has built-in fzf integration with the fzf.fish plugin
# Make sure you've installed it with:
# fisher install PatrickF1/fzf.fish
