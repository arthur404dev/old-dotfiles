# If delta is not installed, install it
if [ ! -f $BREW_PREFIX/bin/delta ]; then
    echo "Installing delta..."
    $BREW_PREFIX/bin/brew install delta
fi
