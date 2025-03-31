set -l marker_file /tmp/fisher_install_in_progress

# Install Fisher if not already installed
if not functions -q fisher; and not test -e $marker_file
  touch $marker_file
  echo "Installing Fisher..."
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  echo "Defined XDG_CONFIG_HOME: $XDG_CONFIG_HOME"
  
  # Just source Fisher first
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
  
  # Now install it permanently
  echo "Installing Fisher permanently..."
  fisher install jorgebucaran/fisher
  
  # Install essential plugins
  echo "Installing plugins..."
  fisher install PatrickF1/fzf.fish
  fisher install franciscolourenco/done
  fisher install jethrokuan/z
  echo "Fisher and essential plugins installed!"
  
  rm $marker_file
end
