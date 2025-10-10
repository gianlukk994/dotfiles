# ─────────────────────────────
# Minimal, Starship-only config
# ─────────────────────────────

# Locale
set -gx LANG en_US.UTF-8

# (Optional) Starship config path
set -Ux STARSHIP_CONFIG ~/.config/starship.toml

# Hide the “Welcome to fish” greeting
set -U fish_greeting

# Pretty man pages via bat
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Android SDK (for React Native)
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/tools/bin
fish_add_path $ANDROID_HOME/platform-tools

# Yarn (classic)
fish_add_path $HOME/.yarn/bin

# Postgres via Homebrew (v12)
fish_add_path /opt/homebrew/opt/postgresql@12/bin

# LLVM headers/libs (only keep if you actually need these)
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Homebrew + editor
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx BUNDLER_EDITOR "code"

# Extra paths
fish_add_path /opt/homebrew/opt/openjdk@17/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path /usr/local/opt/sqlite/bin

# ── Aliases ───────────────────────────────────────────────────────
alias cdw='cd ~/Projects/Nebulab/'
alias addalias='vim ~/.config/fish/config.fish'
alias startmongo='brew services start mongodb-community@5.0'
alias stopmongo='brew services stop mongodb-community@5.0'
alias gch='git checkout'
alias gpl='git pull'
alias gps='git push'
alias gcp='git cherry-pick'
alias gr='git rebase'
alias gl='git log'

function gsnap
    git add .
    git commit -m "snap"
end

# ── Tooling hooks ─────────────────────────────────────────────────
# direnv (auto-load .envrc)
direnv hook fish | source

# asdf version manager
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# ── Prompt (Starship wins) ────────────────────────────────────────
# Keep this LAST so nothing else overrides the prompt
starship init fish | source
