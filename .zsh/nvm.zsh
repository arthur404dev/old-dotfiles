export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$BREW_PREFIX/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# NVM lazy load
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm_lazy='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node_lazy='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm_lazy='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi
