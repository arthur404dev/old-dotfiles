# Load Helpers
[[ -f ~/.zsh/helpers.zsh ]] && source ~/.zsh/helpers.zsh

# Load External configs
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/plugins.zsh ]] && source ~/.zsh/plugins.zsh
($IS_LINUX || $IS_WSL) && [[ -f ~/.zsh/linuxbrew.zsh ]] && source ~/.zsh/linuxbrew.zsh
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
$IS_WSL && [[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Loaders
[[ -f ~/.zsh/loaders.zsh ]] && source ~/.zsh/loaders.zsh

# Load Oh-My-Zsh and then the aliases
[[ -f ~/.zsh/oh-my.zsh ]] && source ~/.zsh/oh-my.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/autocomplete.zsh ]] && source ~/.zsh/autocomplete.zsh

# Exporters
[[ -f ~/.zsh/exporters.zsh ]] && source ~/.zsh/exporters.zsh

# Start tmux if not already running
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
fi

# --->
