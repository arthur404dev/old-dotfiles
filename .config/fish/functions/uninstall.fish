function uninstall
    set -l SILENT false
    set -l SUPPRESS false
    set -l package_name ""
    set -l binary_name ""
    set -l package_manager ""

    # Help message function
    function show_help
        echo "Usage: uninstall [OPTIONS] PACKAGE [BINARY_NAME]"
        echo ""
        echo "Uninstall packages by detecting their package manager"
        echo ""
        echo "Arguments:"
        echo "  PACKAGE          Name of the package to uninstall"
        echo "  BINARY_NAME      Name of the binary to check (defaults to PACKAGE)"
        echo ""
        echo "Options:"
        echo "  -h, --help      Show this help message and exit"
        echo "  -s, --silent    Suppress all output except errors"
        echo "  -su, --suppress Suppress only 'not found' messages"
        echo ""
        echo "Examples:"
        echo "  uninstall bat"
        echo "  uninstall -s bat"
        echo "  uninstall python-pip pip"
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
                set SUPPRESS true
            case --
                set i (math $i + 1)
                break
            case '-*'
                echo "Unknown option: $arg"
                echo "Try 'uninstall --help' for more information."
                return 1
            case '*'
                # Assign positional parameters
                if test -z "$package_name"
                    set package_name $arg
                    set binary_name $arg # Default binary name to package name
                else if test -z "$binary_name"
                    set binary_name $arg
                end
        end
        set i (math $i + 1)
    end

    # Validate required parameters
    if test -z "$package_name"
        echo "Error: Package name is required"
        echo "Try 'uninstall --help' for more information."
        return 1
    end

    # Detect package manager based on binary location
    if test -f "$BREW_PREFIX/bin/$binary_name"
        set package_manager "brew"
        set binary_path "$BREW_PREFIX/bin/$binary_name"
    else if test -f "/usr/bin/$binary_name"
        # Check for apt first (Debian/Ubuntu)
        if command -v apt >/dev/null 2>&1
            set package_manager "apt"
        # Then check for pacman (Arch)
        else if command -v pacman >/dev/null 2>&1
            set package_manager "pacman"
        # Then check for dnf (Fedora)
        else if command -v dnf >/dev/null 2>&1
            set package_manager "dnf"
        end
        set binary_path "/usr/bin/$binary_name"
    else
        test "$SUPPRESS" = false; and test "$SILENT" = false; and echo "Package $package_name not found or not installed"
        return 1
    end

    # Set uninstall command based on detected package manager
    set -l uninstall_cmd ""
    switch $package_manager
        case "brew"
            set uninstall_cmd "$BREW_PREFIX/bin/brew uninstall $package_name"
        case "apt"
            set uninstall_cmd "sudo apt remove -y $package_name"
        case "pacman"
            set uninstall_cmd "sudo pacman -R --noconfirm $package_name"
        case "dnf"
            set uninstall_cmd "sudo dnf remove -y $package_name"
        case '*'
            echo "Error: Could not determine package manager for $package_name"
            return 1
    end

    # Uninstall the package
    test "$SILENT" = false; and echo "(1/2) Uninstalling $package_name using $package_manager..."
    if eval "$uninstall_cmd"
        test "$SILENT" = false; and echo "(2/2) Successfully uninstalled $package_name"
        # Verify removal
        if test -f "$binary_path"
            echo "(1/1) Warning: Binary $binary_name still exists at $binary_path"
        end
    else
        echo "(1/1) Error: Failed to uninstall $package_name"
        return 1
    end
end
