# Checks if tmux is installed, if not, install it
if [ ! -f $BREW_PREFIX/bin/tmux ]; then
  echo "Installing Tmux..."
  $BREW_PREFIX/bin/brew install tmux
fi

# Checks if gitmux is installed, if not, install it
if [ ! -f $BREW_PREFIX/bin/gitmux ]; then
  echo "Installing Gitmux..."
  $BREW_PREFIX/bin/brew tap arl/arl
  $BREW_PREFIX/bin/brew install gitmux
fi

# Start tmux if not already running
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  bash ~/.scripts/tmux-create-random-session.sh
fi
