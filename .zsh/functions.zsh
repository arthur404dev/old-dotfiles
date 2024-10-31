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
