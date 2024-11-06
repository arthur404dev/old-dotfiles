# Load Package Manager (zinit)
[[ -f ~/.zsh/zinit.zsh ]] && source ~/.zsh/zinit.zsh

# Load Helpers
[[ -f ~/.zsh/helpers.zsh ]] && source ~/.zsh/helpers.zsh

# Load External configs
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/plugins.zsh ]] && source ~/.zsh/plugins.zsh
($IS_LINUX || $IS_WSL) && [[ -f ~/.zsh/linuxbrew.zsh ]] && source ~/.zsh/linuxbrew.zsh
$IS_WSL && [[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Loaders
[[ -f ~/.zsh/loaders.zsh ]] && source ~/.zsh/loaders.zsh

# Load Oh-My-Zsh and then the aliases
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/autocomplete.zsh ]] && source ~/.zsh/autocomplete.zsh

# Load Environment Handlers and Libraries
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.zsh/pyenv.zsh ]] && source ~/.zsh/pyenv.zsh
[[ -f ~/.zsh/libs.zsh ]] && source ~/.zsh/libs.zsh
[[ -f ~/.zsh/ollama.zsh ]] && source ~/.zsh/ollama.zsh
[[ -f ~/.zsh/ai.zsh ]] && source ~/.zsh/ai.zsh
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh

# Exporters
[[ -f ~/.zsh/exporters.zsh ]] && source ~/.zsh/exporters.zsh

# Start tmux if not already running
[[ -f ~/.zsh/tmux.zsh ]] && source ~/.zsh/tmux.zsh

# --->
