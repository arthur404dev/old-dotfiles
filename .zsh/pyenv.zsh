# If pyenv is not installed, install it
if [ ! -f $BREW_PREFIX/bin/pyenv ]; then
    echo "Installing pyenv..."
    $BREW_PREFIX/bin/brew install pyenv
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
