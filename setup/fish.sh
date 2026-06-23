#!/usr/bin/env bash
#
# Make fish the default shell and install Oh My Fish.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting Fish Setup >>>"

FISH_BIN="$(command -v fish || true)"
if [[ -z "${FISH_BIN}" ]]; then
    fancy_echo "fish is not installed; skipping."
    exit 0
fi

add_fish_to_shells() {
    if ! grep -Fxq "${FISH_BIN}" /etc/shells; then
        fancy_echo "Adding ${FISH_BIN} to /etc/shells (sudo required)."
        echo "${FISH_BIN}" | sudo tee -a /etc/shells >/dev/null
    fi
}

change_default_shell_to_fish() {
    if [[ "${SHELL:-}" != *fish ]]; then
        fancy_echo "Changing the default shell to fish."
        chsh -s "${FISH_BIN}"
    fi
}

install_omf() {
    if [[ ! -d "${HOME}/.local/share/omf" ]]; then
        fancy_echo "Installing Oh My Fish."
        curl -L https://get.oh-my.fish | fish
    fi
}

if is_ci; then
    fancy_echo "CI detected; skipping shell change and Oh My Fish install."
    exit 0
fi

add_fish_to_shells
change_default_shell_to_fish
install_omf