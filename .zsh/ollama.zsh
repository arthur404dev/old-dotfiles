# Function to start ollama serve in the background
start_ollama() {
  nohup ollama serve >/dev/null 2>&1 &
  disown
}

# Function to view the output of the running ollama serve process
view_ollama_logs() {
  tail -f $(pgrep -f "ollama serve" | xargs -I {} sh -c 'ps -o cmd= {} | sed "s/.*> //"')
}

# Function to restart ollama serve
restart_ollama() {
  pkill -f ollama && ollama serve >/dev/null 2>&1 &
}

ol() {
  local subcommand=$1

  if [[ "$subcommand" == "--help" ]] || [[ "$subcommand" == "help" ]] || [[ -z "$subcommand" ]]; then
    echo "Usage: ol [OPTIONS] COMMAND [ARGS]..."
    echo ""
    echo "  Manage your Ollama instance"
    echo ""
    echo "Options:"
    echo "  --help  Show this message and exit"
    echo ""
    echo "Commands:"
    echo "  start     Start the Ollama server in the background"
    echo "  restart   Restart the Ollama server"
    echo "  view      View the logs of the running Ollama server"
    return 0
  fi

  case "$subcommand" in
  start)
    start_ollama
    ;;
  restart)
    restart_ollama
    ;;
  view)
    view_ollama_logs
    ;;
  *)
    echo "Invalid command: $subcommand"
    echo "Run 'ol help' for usage information."
    ;;
  esac
}

# Check if ollama is already running
if ! pgrep -f "ollama serve" >/dev/null; then
  ol start
fi
