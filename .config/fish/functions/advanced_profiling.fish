function profile_fish_startup
    # Create a temporary file for timing data
    set -l timing_file (mktemp -t fish_profile.XXXXXX)
    
    # Measure total startup time
    fish -c "echo 'Total startup time: '\$(command time -f '%e seconds' fish -c exit 2>&1 | tail -n 1)" > $timing_file
    echo "" >> $timing_file
    
    # Create a profiling script
    set -l profile_script (mktemp -t fish_profile_script.XXXXXX)
    
    echo '
    function __profile_item
        set -l start_time (date +%s%N)
        source $argv[1] 2>/dev/null
        set -l end_time (date +%s%N)
        set -l elapsed_ms (math "($end_time - $start_time) / 1000000")
        echo "$elapsed_ms ms: $argv[1]"
    end
    
    echo "Profiling individual files:"
    
    # Profile config.fish
    __profile_item ~/.config/fish/config.fish
    
    # Profile all files in conf.d directory
    for conf_file in ~/.config/fish/conf.d/*.fish
        __profile_item $conf_file
    end
    
    # Profile all functions
    for func_file in ~/.config/fish/functions/*.fish
        __profile_item $func_file
    end
    
    # Profile completions
    for comp_file in ~/.config/fish/completions/*.fish
        __profile_item $comp_file
    end
    
    functions -e __profile_item
    ' > $profile_script
    
    # Run the profiling script and capture output
    fish $profile_script | sort -n -r >> $timing_file
    
    # Display results
    cat $timing_file
    
    # Clean up
    rm $timing_file
    rm $profile_script
    
    echo ""
    echo "Tip: Look for files taking more than 50ms as potential bottlenecks."
    echo "Common issues include: heavy plugin managers, complex prompts, or slow path manipulations."
end
