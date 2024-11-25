ensure_package eza -s

# Define base commands
base_command="eza --icons"
base_command_no_icons="eza"

# Default directory listing aliases with icons
alias l="$base_command"
alias ls="$base_command"
alias ll="$base_command -lg"
alias la="$base_command -lag"

# Directory listing aliases without icons
alias lni="$base_command_no_icons"
alias lsni="$base_command_no_icons"
alias llni="$base_command_no_icons -lg"
alias lani="$base_command_no_icons -lag"

# Default tree aliases (icons, no lists)
alias lt="$base_command -Tg"
alias lt1="$base_command -Tg --level=1"
alias lt2="$base_command -Tg --level=2"
alias lt3="$base_command -Tg --level=3"

# Tree aliases without icons
alias ltni="$base_command_no_icons -Tg"
alias lt1ni="$base_command_no_icons -Tg --level=1"
alias lt2ni="$base_command_no_icons -Tg --level=2"
alias lt3ni="$base_command_no_icons -Tg --level=3"

# Tree aliases in list mode (icons)
alias llt="$base_command -lTg"
alias llt1="$base_command -lTg --level=1"
alias llt2="$base_command -lTg --level=2"
alias llt3="$base_command -lTg --level=3"

# Tree aliases in list mode without icons
alias lltni="$base_command_no_icons -lTg"
alias llt1ni="$base_command_no_icons -lTg --level=1"
alias llt2ni="$base_command_no_icons -lTg --level=2"
alias llt3ni="$base_command_no_icons -lTg --level=3"
