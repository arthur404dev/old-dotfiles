function debug_fish_startup
    # Enable timing debug output
    set -l fish_debug_output (mktemp -t fish_debug.XXXXXX)
    
    echo "Running Fish with debug timing enabled..."
    env fish_timing=1 fish --command=exit 2> $fish_debug_output
    
    echo "Top 20 slowest operations:"
    grep -E '^Time for' $fish_debug_output | sort -n -k4 -r | head -20
    
    echo ""
    echo "Total initialization time:"
    grep 'startup' $fish_debug_output
    
    # Clean up
    rm $fish_debug_output
end
