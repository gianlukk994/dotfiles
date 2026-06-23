#!/usr/bin/env bash
#
# Bootstrap the dotfiles on a fresh macOS machine.
#
# Installs Homebrew packages (including GNU Stow), symlinks the dotfiles with
# Stow, and runs the remaining setup scripts. Safe to re-run.

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

# Stow packages to link into $HOME. Each lives under stow/<name>.
STOW_PACKAGES=(git vim asdf fish nvim gh starship vscode)

main() {
    # 1. Install Homebrew and the Brewfile packages (includes stow).
    ./setup/homebrew.sh

    # 2. Symlink the dotfiles into $HOME.
    stow -d stow -t "${HOME}" "${STOW_PACKAGES[@]}"

    # 3. Run the remaining setup steps.
    ./setup/macos.sh
    ./setup/asdf.sh
    ./setup/fish.sh
}

main "$@"
