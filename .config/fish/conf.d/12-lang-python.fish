# If pyenv is not installed, install it
if test ! -f $BREW_PREFIX/bin/pyenv
    echo "Installing pyenv..."
    $BREW_PREFIX/bin/brew install pyenv
end

set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path $PYENV_ROOT/bin

if command -v pyenv >/dev/null
    pyenv init - | source
    # Fish doesn't need the --path option
end
