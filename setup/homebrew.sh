#!/usr/bin/env bash
#
# Install Homebrew and the Brewfile packages.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting Homebrew Setup >>>"

install_brew() {
    if command -v brew >/dev/null 2>&1; then
        fancy_echo "Homebrew is already installed."
    else
        fancy_echo "Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_brew
load_brew_shellenv

BREWFILE="${REPO_DIR}/Brewfile"

if is_ci; then
    # GUI casks and Mac App Store apps cannot be installed unattended on a CI
    # runner, so install the formulae (and their taps) only.
    fancy_echo "CI detected; installing formulae only (skipping casks and mas)."
    CI_BREWFILE="$(mktemp)"
    trap 'rm -f "${CI_BREWFILE}"' EXIT
    grep -E '^(tap|brew) ' "${BREWFILE}" > "${CI_BREWFILE}"
    BREWFILE="${CI_BREWFILE}"
fi

brew bundle --file="${BREWFILE}" --verbose
