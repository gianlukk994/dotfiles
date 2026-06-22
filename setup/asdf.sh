#!/usr/bin/env bash
#
# Install asdf plugins and runtimes from ~/.tool-versions.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting asdf Setup >>>"

if ! command -v asdf >/dev/null 2>&1; then
    fancy_echo "asdf is not installed; skipping."
    exit 0
fi

TOOL_VERSIONS="${HOME}/.tool-versions"
if [[ ! -f "${TOOL_VERSIONS}" ]]; then
    fancy_echo "No ${TOOL_VERSIONS} found; skipping runtime install."
    exit 0
fi

# Add a plugin for each tool pinned in ~/.tool-versions.
while read -r plugin _; do
    [[ -z "${plugin}" || "${plugin}" == \#* ]] && continue
    if ! asdf plugin list 2>/dev/null | grep -Fxq "${plugin}"; then
        fancy_echo "Adding asdf plugin: ${plugin}"
        asdf plugin add "${plugin}"
    fi
done < "${TOOL_VERSIONS}"

fancy_echo "Installing runtimes from ${TOOL_VERSIONS}"
asdf install