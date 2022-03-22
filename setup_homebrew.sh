#!/bin/bash

source './utils.sh'

fancy_echo "\n <<< Starting Homebrew Setup >>> \n"

function install_brew() {
    if which brew &> /dev/null; then
        fancy_echo "Homebrew is already installed!"
    else
        fancy_echo "Homebrew is about to be installed!"
	      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_brew

# export HOMEBREW_CASK_OPTS = "--no-quarantine"

brew bundle --verbose
