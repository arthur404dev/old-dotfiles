randomize_session_names() {
    # Define session names, each on a new line for clarity
    session_names=(
        "amaterasu"
        "amun"
        "anubis"
        "aphrodite"
        "apollo"
        "ares"
        "athena"
        "bastet"
        "brahma"
        "fenrir"
        "freyja"
        "freyr"
        "frigg"
        "fuxi"
        "ganesha"
        "guanyin"
        "hachiman"
        "hades"
        "hanuman"
        "hermes"
        "horus"
        "indra"
        "isis"
        "izanagi"
        "izanami"
        "kagutsuchi"
        "kali"
        "loki"
        "nezha"
        "nuwa"
        "nuwa"
        "odin"
        "osiris"
        "poseidon"
        "quetzalcoatl"
        "ra"
        "set"
        "shiva"
        "susano"
        "susanoo"
        "thor"
        "thoth"
        "tsukuyomi"
        "vishnu"
        "wukong"
        "yama"
        "yandi"
        "zeus"
    )

    # Print the session names, pipe them to `shuf` to randomize, then print the randomized list
    printf "%s\n" "${session_names[@]}" | shuf
}

# Start tmux if not already running
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
    for name in $(randomize_session_names); do
        echo $name
        # Check if the session name is already in use
        if ! tmux has-session -t $name 2>/dev/null; then
            # Create a new session with the name
            tmux new-session -d -s $name
            # Attach to the session
            tmux attach-session -t $name
            # Break the loop
            break
        fi
    done
fi
