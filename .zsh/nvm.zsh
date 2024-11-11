# Define NVM_DIR if not already defined
export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm when `nvm`, `node`, or `npm` is invoked
if [ -s "$NVM_DIR/nvm.sh" ]; then
  load_nvm() {
    # Unalias the commands so they don't call this function recursively
    unalias nvm node npm
    # Load nvm script
    . "$NVM_DIR/nvm.sh"
    # Load bash completion if necessary
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    # Call the command that triggered the function, passing any arguments
    "$@"
  }

  # Create aliases that trigger the lazy-loading function
  alias nvm='load_nvm nvm'
  alias node='load_nvm node'
  alias npm='load_nvm npm'
fi
