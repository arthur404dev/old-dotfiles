export XDG_CONFIG_HOME="$HOME/.config"
ENSURE_PACKAGES=false
# Load Package Manager (zinit)
[[ -f ~/.zsh/zinit.zsh ]] && source ~/.zsh/zinit.zsh

# Load Helpers
[[ -f ~/.zsh/helpers.zsh ]] && source ~/.zsh/helpers.zsh

# Load Functions, Aliases and Config
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/config.zsh ]] && source ~/.zsh/config.zsh
[[ -f ~/.zsh/path.zsh ]] && source ~/.zsh/path.zsh
[[ -f ~/.zsh/completions.zsh ]] && source ~/.zsh/completions.zsh

# Load Plugins and Themes
[[ -f ~/.zsh/plugins.zsh ]] && source ~/.zsh/plugins.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Load Homebrew and fix WSL2 interop
[[ -f ~/.zsh/homebrew.zsh ]] && source ~/.zsh/homebrew.zsh
$IS_WSL && [[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh

# Load Environment Handlers and Libraries
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.zsh/pyenv.zsh ]] && source ~/.zsh/pyenv.zsh
[[ -f ~/.zsh/libs.zsh ]] && source ~/.zsh/libs.zsh

# Load Artificial Intelligence
[[ -f ~/.zsh/ollama.zsh ]] && source ~/.zsh/ollama.zsh
[[ -f ~/.zsh/ai.zsh ]] && source ~/.zsh/ai.zsh

# Load All work private files
for file in ~/.zsh/work/*; do
    source $file
done

# Load All Programs from /programs
for file in ~/.zsh/programs/*; do
    source $file
done

# Exporters
[[ -f ~/.zsh/exporters.zsh ]] && source ~/.zsh/exporters.zsh

# Start tmux if not already running
[[ -f ~/.zsh/tmux.zsh ]] && source ~/.zsh/tmux.zsh

# --->
