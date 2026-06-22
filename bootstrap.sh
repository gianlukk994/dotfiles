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
STOW_PACKAGES=(git vim asdf fish nvim gh starship)

# VS Code settings live outside ~/.config, so they are linked explicitly.
VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"

link_vscode_settings() {
    mkdir -p "${VSCODE_USER_DIR}"
    ln -sfn "${BASEDIR}/vscode/settings.json" "${VSCODE_USER_DIR}/settings.json"
}

main() {
    # 1. Install Homebrew and the Brewfile packages (includes stow).
    ./setup_homebrew.sh

    # 2. Symlink the dotfiles into $HOME.
    stow -d stow -t "${HOME}" "${STOW_PACKAGES[@]}"
    link_vscode_settings

    # 3. Run the remaining setup steps.
    ./setup_macos.sh
    ./setup_asdf.sh
    ./setup_vscode.sh
    ./setup_fish.sh
}

main "$@"
