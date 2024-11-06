if $IS_MACOS; then
    # Check if Homebrew is installed, if not, install it
    if [ ! -f /opt/homebrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Add Homebrew to PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
    BREW_PREFIX=/opt/homebrew
else
    # Check if Linuxbrew is installed, if not, install it
    if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install.sh)"
    fi
    # Add Linuxbrew to PATH
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi
