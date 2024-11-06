if [ ! -f $BREW_PREFIX/bin/nvim ]; then
    echo "Installing neovim..."
    $BREW_PREFIX/bin/brew install neovim
fi

# Alias to open neovim
alias vim="nvim"
