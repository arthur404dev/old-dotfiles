function fix
    set -l subcommand $argv[1]
    if test "$subcommand" = "--help" -o "$subcommand" = "help" -o -z "$subcommand"
        echo "Usage: fix [OPTIONS] COMMAND [ARGS]..."
        echo ""
        echo "  Fix various things"
        echo ""
        echo "Options:"
        echo "  --help  Show this message and exit"
        echo ""
        echo "Commands:"
        echo "  history  Repair the Fish history file"
        return 0
    end

    switch $subcommand
        case history
            fix_history
        case '*'
            echo "Invalid command: $subcommand"
            echo "Run 'fix help' for usage information."
    end
end
