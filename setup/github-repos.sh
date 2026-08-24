#!/usr/bin/env bash
#
# Clones repos declared in repos.toml into base_dir (default ~/Projects; see repos.toml.example).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting GitHub Repos Setup >>>"

if is_ci; then
    fancy_echo "CI detected; skipping GitHub repos setup."
    exit 0
fi

CONFIG="${SCRIPT_DIR}/../repos.toml"
if [[ ! -f "${CONFIG}" ]]; then
    fancy_echo "No repos.toml found; copy repos.toml.example to repos.toml and fill it in. Skipping."
    exit 0
fi

if ! command -v gh >/dev/null 2>&1; then
    fancy_echo "gh CLI is not installed; skipping."
    exit 0
fi

if ! gh auth status >/dev/null 2>&1; then
    fancy_echo "gh is not authenticated; run 'gh auth login' first. Skipping."
    exit 0
fi

PROJECTS_DIR="${HOME}/Projects"

# Clone <org>/<repo> into ${PROJECTS_DIR}/<dest>/<org>/<repo> if it isn't there yet.
clone_or_skip() {
    local dest="$1" org="$2" repo="$3"
    local org_dir="${PROJECTS_DIR}/${dest}/${org}"
    local target="${org_dir}/${repo}"

    mkdir -p "${org_dir}"

    if [[ -d "${target}/.git" ]]; then
        fancy_echo "  %s/%s already cloned; skipping." "${org}" "${repo}"
        return
    fi

    fancy_echo "  Cloning %s/%s -> %s" "${org}" "${repo}" "${target}"
    gh repo clone "${org}/${repo}" "${target}"
}

current_dest=""
current_org=""

while IFS= read -r line; do
    # Strip comments and surrounding whitespace.
    line="${line%%#*}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "${line}" ]] && continue

    if [[ "${line}" =~ ^base_dir[[:space:]]*=[[:space:]]*\"(.*)\"$ ]]; then
        PROJECTS_DIR="${BASH_REMATCH[1]/#\~/${HOME}}"
        continue
    fi

    if [[ "${line}" =~ ^\[([A-Za-z0-9_-]+)\.([A-Za-z0-9_.-]+)\]$ ]]; then
        current_dest="${BASH_REMATCH[1]}"
        current_org="${BASH_REMATCH[2]}"
        continue
    fi

    if [[ "${line}" =~ ^repos[[:space:]]*=[[:space:]]*\[(.*)\]$ ]]; then
        [[ -z "${current_dest}" || -z "${current_org}" ]] && continue
        IFS=',' read -ra repo_items <<< "${BASH_REMATCH[1]}"
        for repo in "${repo_items[@]}"; do
            repo="${repo//\"/}"
            repo="${repo#"${repo%%[![:space:]]*}"}"
            repo="${repo%"${repo##*[![:space:]]}"}"
            [[ -z "${repo}" ]] && continue
            clone_or_skip "${current_dest}" "${current_org}" "${repo}"
        done
    fi
done < "${CONFIG}"
