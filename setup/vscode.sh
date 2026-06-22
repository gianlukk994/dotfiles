#!/usr/bin/env bash
#
# Install the VS Code extensions listed in vscode_extension.txt.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting VS Code Setup >>>"

if ! command -v code >/dev/null 2>&1; then
    fancy_echo "VS Code 'code' CLI not found; skipping extensions."
    exit 0
fi

while read -r extension _; do
    [[ -z "${extension}" || "${extension}" == \#* ]] && continue
    code --install-extension "${extension}"
done < "${REPO_DIR}/vscode_extension.txt"
