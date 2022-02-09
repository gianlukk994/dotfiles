#!/bin/bash

source './utils.sh'

fancy_echo "\n <<< Starting asdf Setup >>> \n"

function install_asdf_plugins() {
    fancy_echo "Installing asdf version manager plugins (Ruby, NodeJS and Python)"

    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf plugin-add python
    asdf plugin-add php https://github.com/asdf-community/asdf-php.git
}

function install_asdf_language() {
    local name="$1"
    local version="$2"

    if ! asdf list "$name" | grep -Fq "$version"; then
        fancy_echo "Installing $name $version globally using asdf!"

        asdf install "$name" "$version"
        asdf global "$name" "$version"
    fi
}


install_asdf_plugins
install_asdf_language "ruby" "3.0.2"
install_asdf_language "nodejs" "lts"
install_asdf_language "python" "3.10.0"