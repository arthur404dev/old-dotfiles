# Function to check if a program exists
if_exists() {
  command -v $1 >/dev/null 2>&1
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

fix_history(){
    # Check if the history file exists
    if [[ -f ~/.zsh_history ]]; then
      backup_name=".zsh_history_$(date +%Y%m%d%H%M%S)_bad"
      echo "(1/3) Creating backup $backup_name"

      # Create a timestamped backup of the history file
      mv ~/.zsh_history ~/$backup_name
      print "(2/3) Attempt to repair file"
      # Attempt to repair the history file
      strings ~/$backup_name > ~/.zsh_history

      print "(3/3) Reload History"
      # Reload the history
      fc -R ~/.zsh_history
      rm ~/$backup_name

    else
      print "History file not found."
    fi
}
