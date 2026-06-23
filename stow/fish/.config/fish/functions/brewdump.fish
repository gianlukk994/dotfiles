function brewdump --description 'Dump installed brew, cask, mas and VS Code apps into the dotfiles Brewfile'
    set -l brewfile "$HOME/.dotfiles/Brewfile"
    if not test -f "$brewfile"
        echo "brewdump: $brewfile not found" >&2
        return 1
    end
    command brew bundle dump --force --file="$brewfile"
    echo "Brewfile updated: $brewfile"
end
