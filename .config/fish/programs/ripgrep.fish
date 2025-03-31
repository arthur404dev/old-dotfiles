# If ripgrep is not installed, install it
if test ! -f $BREW_PREFIX/bin/rg
    echo "Installing ripgrep..."
    $BREW_PREFIX/bin/brew install ripgrep
end

ensure_package ripgrep -b rg -s
