function install
    set -l SILENT false
    set -l SUPRESS false
    set -l package_name ""
    set -l binary_name ""
    set -l package_manager "brew"
    set -l binary_path ""
    set -l install_cmd ""

    # Help message function
    function show_help
        echo "Usage: install [OPTIONS] PACKAGE [BINARY_NAME] [PACKAGE_MANAGER]"
        echo ""
        echo "Install packages across different package managers"
        echo ""
        echo "Arguments:"
        echo "  PACKAGE          Name of the package to install"
        echo "  BINARY_NAME      Name of the binary to check (defaults to PACKAGE)"
        echo "  PACKAGE_MANAGER  Package manager to use (brew/apt/pacman/dnf/yum) (defaults to brew)"
        echo ""
        echo "Options:"
        echo "  -h, --help      Show this help message and exit"
        echo "  -s, --silent    Suppress all output except errors"
        echo "  -su, --suppress Suppress only 'already installed' messages"
        echo ""
        echo "Examples:"
        echo "  install bat"
        echo "  install -s bat"
        echo "  install python-pip pip apt"
        echo "  install --silent python-pip pip apt"
    end

    # Parse flags
    set -l i 1
    while test $i -le (count $argv)
        set -l arg $argv[$i]
        switch $arg
            case -h --help
                show_help
                return 0
            case -s --silent
                set SILENT true
            case -su --suppress
                set SUPRESS true
            case --
                set i (math $i + 1)
                break
            case '-*'
                echo "Unknown option: $arg"
                echo "Try 'install --help' for more information."
                return 1
            case '*'
                # Assign positional parameters to variables
                if test -z "$package_name"
                    set package_name $arg
                    set binary_name $arg
                else if test -z "$binary_name"
                    set binary_name $arg
                else
                    set package_manager $arg
                end
        end
        set i (math $i + 1)
    end

    # Validate required parameters
    if test -z "$package_name"
        echo "Error: Package name is required."
        echo "Try 'install --help' for more information."
        return 1
    end

    # Set the binary path and install command based on package manager
    switch $package_manager
        case "brew"
            set binary_path "$BREW_PREFIX/bin/$binary_name"
            set install_cmd "$BREW_PREFIX/bin/brew install $package_name"
        case "apt"
            set binary_path "/usr/bin/$binary_name"
            set install_cmd "sudo apt install -y $package_name"
        case "pacman"
            set binary_path "/usr/bin/$binary_name"
            set install_cmd "sudo pacman -S --noconfirm $package_name"
        case "dnf"
            set binary_path "/usr/bin/$binary_name"
            set install_cmd "sudo dnf install -y $package_name"
        case "yum"
            set binary_path "/usr/bin/$binary_name"
            set install_cmd "sudo yum install -y $package_name"
        case '*'
            echo "Error: Unsupported package manager: $package_manager"
            echo "Supported package managers: brew, apt, pacman, dnf, yum"
            return 1
    end

    # Check if the binary is already installed
    if test ! -f $binary_path
        test "$SILENT" = false; and echo "(1/2) Installing $package_name..."
        if eval $install_cmd
            test "$SILENT" = false; and echo "(2/2) Successfully installed $package_name."
        else
            echo "(2/2) Error: Failed to install $package_name."
            return 1
        end
    else
        test "$SILENT" = false; and test "$SUPRESS" = false; and echo "(1/1) $package_name is already installed."
    end
end
