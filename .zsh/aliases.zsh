# Alias
# ---
#
# Named Directories:
$IS_WSL && WIN_PATH="C:/Users/arthu"
$IS_WSL && hash -d home=/mnt/c/Users/arthu
hash -d dev=~/software-development
# Aliases
$IS_WSL && alias home="cd ~home"
alias dev="cd ~dev"
alias reload="source ~/.zshrc"
alias install="sudo apt-get install"
alias lg="lazygit"
if_exists code && alias zshconfig="code $HOME/.zshrc"
alias delete="rm -rf"
alias myip="curl http://ipecho.net/plain; echo"
$IS_WSL && alias explorer="/mnt/c/Windows/explorer.exe"
# Docker Aliases
if_exists docker && alias drai="docker rmi $(docker images -a -q)"
if_exists docker && alias drac="docker rm $(docker ps -a -q)"
# LSD Config
if_exists lsd && alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
if_exists lsd && alias lt='ls --tree --ignore-glob="**/node_modules/**"'
# Use vscode insiders
alias code="code-insiders"
alias vim="nvim"
