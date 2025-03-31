# Node Version Manager - Volta
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path $VOLTA_HOME/bin

# Node Package Manager - PNPM
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME
