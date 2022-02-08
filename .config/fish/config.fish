
source /usr/local/opt/asdf/asdf.fish

set theme_color_scheme dracula

# Set variables
# Syntax highlight for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Aliases

# Utilities

alias cdp='cd ~/Projects/Private'
alias cds='cd ~/Projects/Sisal'

alias addalias='vim ~/.config/fish/config.fish'

# MongoDB service

alias startmongo='brew services start mongodb-community@5.0'
alias stopmongo='brew services stop mongodb-community@5.0'
fish_add_path /usr/local/opt/sqlite/bin

# Npm utilities
alias npmpublic='npm set registry https://registry.npmjs.org/'
alias npmsisal='npm set registry http://10.29.10.4:9082/repository/npm-pam/'

# Git utilites
alias gch='git checkout'
alias gpl='git pull'
alias gps='git push'

