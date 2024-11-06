# Named Directories:
$IS_WSL && WIN_PATH="C:/Users/arthu"
$IS_WSL && hash -d home=/mnt/c/Users/arthu
# If software-development is not a directory, create it
if [ ! -d ~/software-development ]; then
    mkdir -p ~/software-development/work
fi
hash -d dev=~/software-development
# Aliases
$IS_WSL && alias home="cd ~home"
alias dev="cd ~dev"
alias dot="cd ~/dotfiles"
alias reload="source ~/.zshrc"
alias install="sudo apt-get install"
if_exists code && alias zshconfig="code $HOME/.zshrc"
alias delete="rm -rf"
alias myip="curl http://ipecho.net/plain; echo"
$IS_WSL && alias explorer="/mnt/c/Windows/explorer.exe"
# Docker Aliases
if_exists docker && alias drai="docker rmi $(docker images -a -q)"
if_exists docker && alias drac="docker rm $(docker ps -a -q)"
# Use vscode insiders
alias code="code-insiders"
