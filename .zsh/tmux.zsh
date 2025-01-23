# Checks if tmux is installed, if not, install it
if [ ! -f $BREW_PREFIX/bin/tmux ]; then
  echo "Installing Tmux..."
  $BREW_PREFIX/bin/brew install tmux
fi

# Start tmux if not already running
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  bash ~/.scripts/tmux-create-random-session.sh
fi
