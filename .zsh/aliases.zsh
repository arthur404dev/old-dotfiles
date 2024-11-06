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
# Use vscode insiders
alias code="code-insiders"
