#!/usr/bin/env bash
#
# Install ambit (https://github.com/nebulab/ambit), the dependency manager
# for AI agent skills/hooks/MCP servers, if it isn't already on PATH.
#
# ambit's own config (~/ambit.yml) and generated state (~/.agents/) are
# machine-local and intentionally NOT tracked in this repo, since they can
# reference private catalogs or local paths. Set them up by hand after this
# script runs (see README's "ambit" section), then run `ambit install`.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting ambit Setup >>>"

if is_ci; then
    fancy_echo "CI detected; skipping ambit install."
    exit 0
fi

if command -v ambit >/dev/null 2>&1; then
    fancy_echo "ambit is already installed; skipping."
    exit 0
fi

fancy_echo "Installing ambit."
# Pin to a known-good tag by default (override with AMBIT_INSTALL_REF) so the
# install script can't change underneath us, and fetch-then-run rather than
# piping directly from curl into a shell.
AMBIT_INSTALL_REF="${AMBIT_INSTALL_REF:-v0.2.0}"
INSTALL_SCRIPT="$(mktemp)"
trap 'rm -f "${INSTALL_SCRIPT}"' EXIT
curl -fsSL "https://raw.githubusercontent.com/nebulab/ambit/${AMBIT_INSTALL_REF}/install.sh" -o "${INSTALL_SCRIPT}"
bash "${INSTALL_SCRIPT}"
