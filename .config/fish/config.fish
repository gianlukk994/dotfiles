
source /usr/local/opt/asdf/asdf.fish

set theme_color_scheme dracula
set -g theme_display_ruby no

# Set variables
# Syntax highlight for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Aliases

# Utilities
alias addalias='vim ~/.config/fish/config.fish'

# MongoDB service
alias startmongo='brew services start mongodb-community@5.0'
alias stopmongo='brew services stop mongodb-community@5.0'

fish_add_path /usr/local/opt/sqlite/bin

# Npm utilities

# Git utilites
alias gch='git checkout'
alias gpl='git pull'
alias gps='git push'

