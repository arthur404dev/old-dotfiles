ai_chat() {
  if [[ "$2" == "-d" || "$2" == "--default" || "$2" == "default" ]]; then
    # If -d, --default, or default is specified, run llm chat without --model
    llm chat
  elif [[ -z "$2" ]]; then
    # If no model is specified, proceed with model selection
    local models
    models=$(llm models)
    local selected_model_name

    # Ensure `select_item` is defined before calling
    if ! command -v select_item &>/dev/null; then
      echo "Error: select_item function is not defined."
      return 1
    fi

    select_item "Select a model: " "$models" "model"

    # Extract the model name from the selected line
    selected_model_name=$(echo "$selected_model" | awk -F': ' '{print $2}' | awk '{print $1}')

    if [[ -z "$selected_model_name" ]]; then
      echo "Error: No model selected."
      return 1
    fi

    # Run llm chat with the selected model
    llm chat --model="$selected_model_name"
  else
    # If a model is specified, run llm chat with that model
    llm chat --model="$2"
  fi
}

ai_explain() {
  local filename=""
  if [[ -z "$2" ]]; then
    # If no file is specified, use select_item to select one from the current directory
    local files
    files=$(ls -1)
    if ! command -v select_item &>/dev/null; then
      echo "Error: select_item function is not defined."
      return 1
    fi
    filename=$(select_item "Select the file to Explain: " "$files" "file")
  else
    # If a file is specified, use it
    filename="$2"
  fi

  if [[ -z "$filename" ]]; then
    echo "Usage: ai explain <file_name>"
    echo "No file specified."
    return 1
  fi

  # Check if the file exists
  if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' does not exist."
    return 1
  fi

  local tempfile
  tempfile=$(mktemp)
  local spinner=("-" "\\" "|" "/")
  local i=0
  local start_time
  start_time=$(date +%s)

  # Run the command in the background
  (llm 'Explain this file' --no-stream <"$filename" >"$tempfile") &

  # Display the spinner while the command is running
  tput cuu 1
  tput el
  local pid="$!"
  while kill -0 "$pid" 2>/dev/null; do
    i=$(((i + 1) % 4))
    local k=$(((i + 1) % 2 ? 4 : 2))
    printf "\r -> Thinking...[$(tput setaf "$k")${spinner:$i:1}$(tput sgr0)] \r"
    sleep 0.1
  done

  # Wait for the background process to complete
  wait "$pid"

  # Check if the command was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to process file '$filename'"
    rm "$tempfile"
    return 1
  fi

  # Calculate the elapsed time
  local end_time
  end_time=$(date +%s)
  local elapsed_time=$((end_time - start_time))

  tput cuu 2
  tput el

  # Print a newline after the command completes
  printf "\rFile %s explained in %s seconds.\n" "$filename" "$elapsed_time"
  glow <"$tempfile"
  rm "$tempfile"
}

ai() {
  local subcommand=$1
  if [[ "$subcommand" == "--help" || "$subcommand" == "help" || -z "$subcommand" ]]; then
    echo "Usage: ai [OPTIONS] COMMAND [ARGS]..."
    echo ""
    echo "  Manage your Artificial Intelligence instance"
    echo ""
    echo "Options:"
    echo "  --help    Show this message and exit"
    echo ""
    echo "Commands:"
    echo "  chat     Start an interactive chat session with AI"
    echo "  explain  Analyze and explain the contents of a file"
    echo ""
    echo "Examples:"
    echo "  ai chat                   # Start chat with model selection"
    echo "  ai chat default           # Start chat with default model"
    echo "  ai chat gpt-4             # Start chat with specific model"
    echo "  ai explain script.sh      # Explain contents of script.sh"
    echo "  ai explain                # Select and explain a file interactively"
    return 0
  fi

  case "$subcommand" in
  chat)
    ai_chat "$@"
    ;;
  explain)
    ai_explain "$@"
    ;;
  *)
    echo "Error: Invalid command '$subcommand'"
    echo "Run 'ai --help' for usage information."
    return 1
    ;;
  esac
}
