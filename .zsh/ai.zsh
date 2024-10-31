ai_chat() {
    if [[ "$2" == "-d" ]] || [[ "$2" == "--default" ]] || [[ "$2" == "default" ]]; then
        # If -d, --default, or default is specified, run llm chat without --model
        llm chat
    elif [[ -z "$2" ]]; then
        # If no model is specified, proceed with model selection
        local models=$(llm models)
        local selected_model_name

        # Check if fzf is installed
        if if_exists fzf; then
            # If fzf is installed, use it for model selection
            local selected_model=$(echo "$models" | fzf --height=40% --layout=reverse --border --prompt="Select a model: ")
        else
            # If fzf is not installed, fall back to the basic selection method
            local i=1
            echo "$models" | while read -r line; do
                echo "($i) $line"
                i=$((i + 1))
            done

            local selected_model
            vared -p "Select a model number: " selected_model
            selected_model=$(echo "$models" | sed -n "${selected_model}p")
        fi

        # Extract the model name from the selected line
        selected_model_name=$(echo "$selected_model" | awk -F': ' '{print $2}' | awk '{print $1}')

        # Run llm chat with the selected model
        llm chat --model="$selected_model_name"
    else
        # If a model is specified, run llm chat with that model
        llm chat --model="$2"
    fi
}

ai_explain() {

}

ai_prompt() {

}

ai_cmd() {

}

ai_code() {

}

ai() {
    local subcommand=$1

    if [[ "$subcommand" == "--help" ]] || [[ "$subcommand" == "help" ]] || [[ -z "$subcommand" ]]; then
        echo "Usage: ai [OPTIONS] COMMAND [ARGS]..."
        echo ""
        echo "  Manage your Artificial Intelligence instance"
        echo ""
        echo "Options:"
        echo "  --help  Show this message and exit"
        echo ""
        echo "Commands:"
        echo "  chat      Start a chat with the AI choosing a model or passing a model name"
        echo "  prompt    Start a prompt with the AI choosing a model or passing a model name"
        return 0
    fi

    case "$subcommand" in
    chat)
        ai_chat "$@"
        ;;
    prompt)
        ai_prompt "$@"
        ;;
    cmd)
        ai_cmd "$@"
        ;;
    *)
        echo "Invalid command: $subcommand"
        echo "Run 'ai help' for usage information."
        ;;
    esac
}

funczinha() {
    vared -p "Type your username: " username

    echo "Hello $username"
}
