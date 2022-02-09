#!/bin/bash

source './utils.sh'

fancy_echo "\n <<< Starting Fish Setup >>> \n"

function add_fish_to_shells() {
    # Check if fish is listed in availables shells
    if ! grep "$(which fish)" /etc/shells > /dev/null 2>&1; then
        fancy_echo "Enter sudo password to edit /etc/shells"
        echo '/usr/local/bin/fish' | sudo tee -a '/etc/shells'
    fi
}

function change_default_shell_to_fish() {
    # Check if the used shell is already set to fish
    if [[ $SHELL != *"fish"* ]]; then
        # Check if fish is installed
        if which fish > /dev/null 2>&1; then
            fancy_echo "Changing your shell to fish!"

            chsh -s $(which fish) $USER
        fi
    fi
}

function install_omf() {
    if [ ! -d "$HOME/.local/share/omf" ]; then
        fancy_echo "Installing Oh my Fish!"

        curl -L https://get.oh-my.fish | fish
    fi
}

add_fish_to_shells
change_default_shell_to_fish
install_omf