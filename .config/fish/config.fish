
source /usr/local/opt/asdf/asdf.fish
source /usr/local/opt/asdf/libexec/asdf.fish

set theme_color_scheme dracula
set -g theme_display_ruby no

# Set variables

# Syntax highlight for man pages using bat
set -xg MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Update the ANDROID_HOME, this is needed for react native
set -xg ANDROID_HOME "$HOME/Library/Android/sdk"
set -xg PATH "$PATH:$ANDROID_HOME/emulator"
set -xg PATH "$PATH:$ANDROID_HOME/tools"
set -xg PATH "$PATH:$ANDROID_HOME/tools/bin"
set -xg PATH "$PATH:$ANDROID_HOME/platform-tools"
# set -xg JAVA_HOME "/usr/libexec/java_home"
 

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

