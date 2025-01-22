export XDG_CONFIG_HOME="$HOME/.config"
ENSURE_PACKAGES=false

# Load Package Manager (zinit)
[[ -f "$HOME/.zsh/zinit.zsh" ]] && source "$HOME/.zsh/zinit.zsh"

# Load Helpers
[[ -f "$HOME/.zsh/helpers.zsh" ]] && source "$HOME/.zsh/helpers.zsh"

# Load Functions, Aliases, and Config
[[ -f "$HOME/.zsh/functions.zsh" ]] && source "$HOME/.zsh/functions.zsh"
[[ -f "$HOME/.zsh/aliases.zsh" ]] && source "$HOME/.zsh/aliases.zsh"
[[ -f "$HOME/.zsh/config.zsh" ]] && source "$HOME/.zsh/config.zsh"
[[ -f "$HOME/.zsh/path.zsh" ]] && source "$HOME/.zsh/path.zsh"
[[ -f "$HOME/.zsh/completions.zsh" ]] && source "$HOME/.zsh/completions.zsh"

# Load Plugins and Themes
[[ -f "$HOME/.zsh/plugins.zsh" ]] && source "$HOME/.zsh/plugins.zsh"
[[ -f "$HOME/.zsh/starship.zsh" ]] && source "$HOME/.zsh/starship.zsh"

# Load Homebrew and fix WSL2 interop
[[ -f "$HOME/.zsh/homebrew.zsh" ]] && source "$HOME/.zsh/homebrew.zsh"
$IS_WSL && [[ -f "$HOME/.zsh/wsl2fix.zsh" ]] && source "$HOME/.zsh/wsl2fix.zsh"

# Load Environment Handlers and Libraries
# [[ -f "$HOME/.zsh/nvm.zsh" ]] && source "$HOME/.zsh/nvm.zsh"
[[ -f "$HOME/.zsh/volta.zsh" ]] && source "$HOME/.zsh/volta.zsh"
[[ -f "$HOME/.zsh/pnpm.zsh" ]] && source "$HOME/.zsh/pnpm.zsh"
[[ -f "$HOME/.zsh/pyenv.zsh" ]] && source "$HOME/.zsh/pyenv.zsh"
[[ -f "$HOME/.zsh/libs.zsh" ]] && source "$HOME/.zsh/libs.zsh"

# Load Artificial Intelligence
[[ -f "$HOME/.zsh/ollama.zsh" ]] && source "$HOME/.zsh/ollama.zsh"
[[ -f "$HOME/.zsh/ai.zsh" ]] && source "$HOME/.zsh/ai.zsh"

# Load All work private files
if [ -d "$HOME/.zsh/work" ] && [ "$(ls -A "$HOME/.zsh/work")" ]; then
  for file in "$HOME/.zsh/work/"*; do
    # shellcheck source=/dev/null
    source "$file"
  done
fi

# Load All Programs from /programs
if [ -d "$HOME/.zsh/programs" ] && [ "$(ls -A "$HOME/.zsh/programs")" ]; then
  for file in "$HOME/.zsh/programs/"*; do
    # shellcheck source=/dev/null
    source "$file"
  done
fi

# Start tmux if not already running
if [ -z "$SSH_CONNECTION" ] && [ -f "$HOME/.zsh/tmux.zsh" ]; then
  source "$HOME/.zsh/tmux.zsh"
fi

# -- System Added...
