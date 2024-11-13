# If software-development is not a directory, create it
if [ ! -d ~/software-development ]; then
    mkdir -p ~/software-development/work
fi
hash -d dev=~/software-development
# Aliases
alias dev="cd ~dev"
alias dot="cd ~/dotfiles"
alias reload="source ~/.zshrc"
if_exists code && alias zshconfig="code $HOME/.zshrc"
alias delete="rm -rf"
alias myip="curl http://ipecho.net/plain; echo"
$IS_WSL && alias explorer="/mnt/c/Windows/explorer.exe"
# Docker Aliases
if_exists docker && alias drai="docker rmi $(docker images -a -q)"
if_exists docker && alias drac="docker rm $(docker ps -a -q)"
alias c="code"
alias ci="code-insiders"
alias cu="cursor"
# Copy
$IS_LINUX && if_exists "xclip" && alias copy="xclip"
$IS_WSL && if_exists "clip.exe" && alias copy="clip.exe"
$IS_MACOS && if_exists "pbcopy" && alias copy="pbcopy"
