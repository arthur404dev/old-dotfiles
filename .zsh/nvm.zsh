# Define nvm setup function
nvm_load() {
    # Load nvm from Homebrew installation
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
}

# Create placeholder functions
nvm() {
    unset -f nvm node npm npx
    nvm_load
    nvm "$@"
}

node() {
    unset -f nvm node npm npx
    nvm_load
    node "$@"
}

npm() {
    unset -f nvm node npm npx
    nvm_load
    npm "$@"
}

npx() {
    unset -f nvm node npm npx
    nvm_load
    npx "$@"
}
