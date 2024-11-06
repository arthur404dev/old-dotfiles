# If glow is not installed, install it
if [ ! -f $BREW_PREFIX/bin/glow ]; then
    echo "Installing glow..."
    $BREW_PREFIX/bin/brew install glow
fi
