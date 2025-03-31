function sg
    # 1. Search for text in files using Ripgrep
    rg --color=always --line-number --no-heading --smart-case $argv |
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
end
