# Fish uses emacs keybindings by default
# To use vi keybindings: fish_vi_key_bindings

fish_vi_key_bindings

# Custom key bindings
bind \cp history-search-backward
bind \cn history-search-forward
bind \ew kill-word  # Alt+w to kill region

# History configuration
set -g fish_history_max_length 1000
set -g fish_history_save_not_valid true
set -g fish_history_ignore_space true
