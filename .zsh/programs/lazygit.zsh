# If lazygit is not installed, install it
if [ ! -f $BREW_PREFIX/bin/lazygit ]; then
    echo "Installing lazygit..."
    $BREW_PREFIX/bin/brew install lazygit
fi

# Alias to open lazygit
alias gg="lazygit"
