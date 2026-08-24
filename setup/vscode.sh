#!/usr/bin/env bash
#
# Rewrite the vscode_custom_css.imports path in settings.json to point at
# this machine's $HOME.
#
# The "Custom CSS and JS Loader" extension requires a literal file:// URI
# and does not expand $HOME/~, so the committed settings.json necessarily
# contains one user's absolute path. Since settings.json is stowed (a
# symlink into this repo), this script patches that same tracked file to
# use the current $HOME, making it work out of the box on any machine/user
# without a manual edit. Safe to re-run (idempotent).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting VS Code Setup >>>"

SETTINGS="${HOME}/Library/Application Support/Code/User/settings.json"

if [[ ! -f "${SETTINGS}" ]]; then
    fancy_echo "VS Code settings.json not found (yet); skipping."
    exit 0
fi

sed -i '' -E \
    "s#file:///Users/[^/]+(/Library/Application Support/Code/User/custom-vscode\.css)#file://${HOME}\1#" \
    "${SETTINGS}"

fancy_echo "vscode_custom_css.imports now points at ${HOME}."
