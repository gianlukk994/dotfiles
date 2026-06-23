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
    # CI already has Homebrew, so install only the package bootstrap needs.
    fancy_echo "CI detected; installing stow only."
    brew install stow
    exit 0
fi

brew bundle --file="${BREWFILE}" --verbose
