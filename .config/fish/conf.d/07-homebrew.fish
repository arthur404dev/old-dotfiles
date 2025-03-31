if test "$IS_MACOS" = "true"
    # Check if Homebrew is installed, if not, install it
    if test ! -f /opt/homebrew/bin/brew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    end
    # Add Homebrew to PATH
    eval (/opt/homebrew/bin/brew shellenv)
    set -gx BREW_PREFIX /opt/homebrew
else
    # Check if Linuxbrew is installed, if not, install it
    if test ! -f /home/linuxbrew/.linuxbrew/bin/brew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install.sh)"
    end
    # Add Linuxbrew to PATH
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    set -gx BREW_PREFIX /home/linuxbrew/.linuxbrew
end
