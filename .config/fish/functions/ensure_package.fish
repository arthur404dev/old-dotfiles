function ensure_package
    set -l SILENT false
    set -l SUPPRESS false
    set -l package_name ""
    set -l binary_name ""
    set -l package_manager ""
    set -l FLAGS ""

    # Help message function
    function show_help
        echo "Usage: ensure_package [OPTIONS] PACKAGE"
        echo ""
        echo "Ensure a package is installed, installing it if necessary"
        echo ""
        echo "Arguments:"
        echo "  PACKAGE          Name of the package to ensure"
        echo ""
        echo "Options:"
        echo "  -h, --help      Show this help message and exit"
        echo "  -s, --silent    Suppress all output"
        echo "  -su, --suppress Suppress only 'already installed' messages"
        echo "  -b, --binary    Specify binary name (defaults to package name)"
        echo "  -p, --package-manager  Package manager to use (defaults to auto-detect)"
        echo ""
        echo "Examples:"
        echo "  ensure_package bat"
        echo "  ensure_package -s bat"
        echo "  ensure_package python-pip -b pip -p apt"
    end

    if test "$ENSURE_PACKAGES" = "false"
        return 0
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
                set FLAGS "$FLAGS -s"
            case -su --suppress
                set SUPPRESS true
                set FLAGS "$FLAGS -su"
            case -b --binary
                set i (math $i + 1)
                set binary_name $argv[$i]
            case -p --package-manager
                set i (math $i + 1)
                set package_manager $argv[$i]
            case --
                set i (math $i + 1)
                break
            case '-*'
                echo "Unknown option: $arg"
                echo "Try 'ensure_package --help' for more information."
                return 1
            case '*'
                if test -z "$package_name"
                    set package_name $arg
                else
                    echo "Error: Unexpected argument: $arg"
                    echo "Try 'ensure_package --help' for more information."
                    return 1
                end
        end
        set i (math $i + 1)
    end

    # Validate required parameters
    if test -z "$package_name"
        echo "Error: Package name is required"
        echo "Try 'ensure_package --help' for more information."
        return 1
    end

    # Set binary name to package name if not specified
    if test -z "$binary_name"
        set binary_name $package_name
    end

    # First check if the command already exists
    if command -v "$binary_name" >/dev/null 2>&1
        test "$SILENT" = false; and test "$SUPPRESS" = false; and echo "Package $package_name is already installed"
        return 0
    end

    # Auto-detect package manager if not specified
    if test -z "$package_manager"
        if command -v brew >/dev/null 2>&1
            set package_manager "brew"
        else if command -v apt >/dev/null 2>&1
            set package_manager "apt"
        else if command -v pacman >/dev/null 2>&1
            set package_manager "pacman"
        else if command -v dnf >/dev/null 2>&1
            set package_manager "dnf"
        else
            echo "Error: Could not detect package manager"
            return 1
        end
    end

    # Only install if the command doesn't exist
    install $FLAGS "$package_name" "$binary_name" "$package_manager"
end
