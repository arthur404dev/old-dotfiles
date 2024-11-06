if [ ! -f $BREW_PREFIX/bin/zoxide ]; then
    echo "Installing zoxide..."
    $BREW_PREFIX/bin/brew install zoxide
fi
# Source zoxide
eval "$(zoxide init --cmd cd zsh)"
