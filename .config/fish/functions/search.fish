function search
    grep -r $argv[1] $argv[2] | fzf --height=40% --border --tmux=center --prompt="Search: "
end
