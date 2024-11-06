# If lsd is not installed, install it
if [ ! -f $BREW_PREFIX/bin/lsd ]; then
    echo "Installing lsd..."
    $BREW_PREFIX/bin/brew install lsd
fi

# LSD Config
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --ignore-glob="**/node_modules/**"'
