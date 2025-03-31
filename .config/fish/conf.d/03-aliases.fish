# If software-development is not a directory, create it
if test ! -d ~/software-development
    mkdir -p ~/software-development/work
end

# Aliases
alias dev="cd ~/software-development"
alias dot="cd ~/dotfiles"
alias reload="source ~/.config/fish/config.fish"
if command -v code >/dev/null 2>&1
    alias fishconfig="code $HOME/.config/fish/config.fish"
end
alias delete="rm -rf"
alias myip="curl http://ipecho.net/plain; echo"
if test "$IS_WSL" = "true"
    alias explorer="/mnt/c/Windows/explorer.exe"
end

# Docker Aliases
if command -v docker >/dev/null 2>&1
    alias drai="docker rmi (docker images -a -q)"
    alias drac="docker rm (docker ps -a -q)"
end

alias c="code"
alias ci="code-insiders"
alias cu="cursor"

# Copy
if test "$IS_LINUX" = "true"; and command -v xclip >/dev/null 2>&1
    alias copy="xclip"
end
if test "$IS_WSL" = "true"; and command -v clip.exe >/dev/null 2>&1
    alias copy="clip.exe"
end
if test "$IS_MACOS" = "true"; and command -v pbcopy >/dev/null 2>&1
    alias copy="pbcopy"
end
