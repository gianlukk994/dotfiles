function brew --wraps brew --description 'Run brew and refresh the dotfiles Brewfile after changes'
    command brew $argv
    set -l brew_status $status

    # After a successful mutating command, refresh the Brewfile so newly
    # installed (or removed) formulae, casks, App Store and VS Code apps are
    # captured in the dotfiles repo. Review and commit the change yourself.
    if test $brew_status -eq 0
        switch "$argv[1]"
            case install uninstall remove rm reinstall tap untap
                brewdump
        end
    end

    return $brew_status
end
