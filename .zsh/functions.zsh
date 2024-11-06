# Function to check if a program exists
if_exists() {
  command -v $1 >/dev/null 2>&1
}

silent_background() {
  { "$@" 2>&3 & } 3>&2 2>/dev/null
  disown &>/dev/null
}

clear_entire_output() {
  print -z '\e[2J\e[H'
}

# Searches recursively in a folder / file and pipes into fzf
search() {
  grep -r $1 $2 | fzf --height=40% --border --tmux=center --prompt="Search: "
}

sg() {
  # 1. Search for text in files using Ripgrep
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    # 2. Interactively narrow down the list using fzf
    fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --border \
      --tmux=80% \
      --delimiter : \
      --preview "bat --number --color=always {1} --highlight-line {2}" \
      --header-first \
      --header="Refine search and press enter to open file (press ctrl-c to exit)" \
      --preview-window "up,60%,border-bottom,+{2}+3/3,~3" \
      --bind "enter:become(nvim {1} +{2})" # 3. Open the file in nvim
}

# Function to fix various things, including history
fix() {
  local subcommand=$1
  shift # Remove the subcommand from the argument list

  if [[ "$subcommand" == "--help" ]] || [[ "$subcommand" == "help" ]] || [[ -z "$subcommand" ]]; then
    echo "Usage: fix [OPTIONS] COMMAND [ARGS]..."
    echo ""
    echo "  Fix various things"
    echo ""
    echo "Options:"
    echo "  --help  Show this message and exit"
    echo ""
    echo "Commands:"
    echo "  history  Repair the Zsh history file"
    # Add more commands here in the future...
    return 0
  fi

  case "$subcommand" in
  history)
    fix_history
    ;;
  *)
    echo "Invalid command: $subcommand"
    echo "Run 'fix help' for usage information."
    ;;
  esac
}

fix_history() {
  # Check if the history file exists
  if [[ -f ~/.zsh_history ]]; then
    backup_name=".zsh_history_$(date +%Y%m%d%H%M%S)_bad"
    echo "(1/3) Creating backup $backup_name"

    # Create a timestamped backup of the history file
    mv ~/.zsh_history ~/$backup_name
    print "(2/3) Attempt to repair file"
    # Attempt to repair the history file
    strings ~/$backup_name >~/.zsh_history

    print "(3/3) Reload History"
    # Reload the history
    fc -R ~/.zsh_history
    rm ~/$backup_name

  else
    print "History file not found."
  fi
}

select_item() {
  local prompt="$1"
  local items="$2"
  local fallback_label="$3" # New parameter for fallback label
  local selected_item=""

  # Checks if fzf is installed and uses it if available, otherwise uses a basic selection
  if if_exists fzf; then
    selected_item=$(echo "$items" | fzf --height=40% --layout=reverse --border --prompt="$prompt")
  else
    local i=1
    echo "$items" | while read -r item; do
      echo "($i) $item"
      i=$((i + 1))
    done

    local selected_index
    # Use the provided fallback label or default to "item"
    vared -p "Select a ${fallback_label:-item} number: " selected_index
    selected_item=$(echo "$items" | sed -n "${selected_index}p")
  fi

  echo "$selected_item"
}

install() {
  SILENT=false
  SUPRESS=false
  package_name=""
  binary_name=""
  package_manager="brew"
  binary_path=""
  install_cmd=""

  # Help message function
  show_help() {
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
  }

  # Parse flags
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
    -h | --help)
      show_help
      return 0
      ;;
    -s | --silent)
      SILENT=true
      ;;
    -su | --suppress)
      SUPRESS=true
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1"
      echo "Try 'install --help' for more information."
      return 1
      ;;
    *)

      # Assign positional parameters to variables
      if [ -z "$package_name" ]; then
        package_name=$1
        binary_name=$1
      elif [ -z "$binary_name" ]; then
        binary_name=$1
      else
        package_manager=$1
      fi
      ;;

    esac
    shift
  done

  # Validate required parameters
  if [ -z "$package_name" ]; then
    echo "Error: Package name is required."
    echo "Try 'install --help' for more information."
    return 1
  fi

  # Set the binary path and install command based on package manager
  case $package_manager in
  "brew")
    binary_path="$BREW_PREFIX/bin/$binary_name"
    install_cmd="$BREW_PREFIX/bin/brew install $package_name"
    ;;
  "apt")
    binary_path="/usr/bin/$binary_name"
    install_cmd="sudo apt install -y $package_name"
    ;;
  "pacman")
    binary_path="/usr/bin/$binary_name"
    install_cmd="sudo pacman -S --noconfirm $package_name"
    ;;
  "dnf")
    binary_path="/usr/bin/$binary_name"
    install_cmd="sudo dnf install -y $package_name"
    ;;
  "yum")
    binary_path="/usr/bin/$binary_name"
    install_cmd="sudo yum install -y $package_name"
    ;;
  *)
    echo "Error: Unsupported package manager: $package_manager"
    echo "Supported package managers: brew, apt, pacman, dnf, yum"
    return 1
    ;;
  esac

  # Check if the binary is already installed
  if [ ! -f $binary_path ]; then
    [ "$SILENT" = false ] && echo "(1/2) Installing $package_name..."
    if eval $install_cmd; then
      [ "$SILENT" = false ] && echo "(2/2) Successfully installed $package_name."
    else
      echo "(2/2) Error: Failed to install $package_name."
      return 1
    fi
  else
    [ "$SILENT" = false ] && [ "$SUPRESS" = false ] && echo "(1/1) $package_name is already installed."
  fi
}

uninstall() {
  SILENT=false
  SUPPRESS=false
  package_name=""
  binary_name=""
  package_manager=""

  # Help message function
  show_help() {
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
  }

  # Parse flags
  while [[ "$#" -gt 0 ]]; do
    case $1 in
    -h | --help)
      show_help
      return 0
      ;;
    -s | --silent)
      SILENT=true
      ;;
    -su | --suppress)
      SUPPRESS=true
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1"
      echo "Try 'uninstall --help' for more information."
      return 1
      ;;
    *)
      # Assign positional parameters
      if [ -z "$package_name" ]; then
        package_name=$1
        binary_name=$1 # Default binary name to package name
      elif [ -z "$binary_name" ]; then
        binary_name=$1
      fi
      ;;
    esac
    shift
  done

  # Validate required parameters
  if [ -z "$package_name" ]; then
    echo "Error: Package name is required"
    echo "Try 'uninstall --help' for more information."
    return 1
  fi

  # Detect package manager based on binary location
  if [ -f "$BREW_PREFIX/bin/$binary_name" ]; then
    package_manager="brew"
    binary_path="$BREW_PREFIX/bin/$binary_name"
  elif [ -f "/usr/bin/$binary_name" ]; then
    # Check for apt first (Debian/Ubuntu)
    if command -v apt >/dev/null 2>&1; then
      package_manager="apt"
    # Then check for pacman (Arch)
    elif command -v pacman >/dev/null 2>&1; then
      package_manager="pacman"
    # Then check for dnf (Fedora)
    elif command -v dnf >/dev/null 2>&1; then
      package_manager="dnf"
    fi
    binary_path="/usr/bin/$binary_name"
  else
    [ "$SUPPRESS" = false ] && [ "$SILENT" = false ] && echo "Package $package_name not found or not installed"
    return 1
  fi

  # Set uninstall command based on detected package manager
  local uninstall_cmd=""
  case $package_manager in
  "brew")
    uninstall_cmd="$BREW_PREFIX/bin/brew uninstall $package_name"
    ;;
  "apt")
    uninstall_cmd="sudo apt remove -y $package_name"
    ;;
  "pacman")
    uninstall_cmd="sudo pacman -R --noconfirm $package_name"
    ;;
  "dnf")
    uninstall_cmd="sudo dnf remove -y $package_name"
    ;;
  *)
    echo "Error: Could not determine package manager for $package_name"
    return 1
    ;;
  esac

  # Uninstall the package
  [ "$SILENT" = false ] && echo "(1/2) Uninstalling $package_name using $package_manager..."
  if eval "$uninstall_cmd"; then
    [ "$SILENT" = false ] && echo "(2/2) Successfully uninstalled $package_name"
    # Verify removal
    if [ -f "$binary_path" ]; then
      echo "(1/1) Warning: Binary $binary_name still exists at $binary_path"
    fi
  else
    echo "(1/1) Error: Failed to uninstall $package_name"
    return 1
  fi
}
