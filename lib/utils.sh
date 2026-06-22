#!/usr/bin/env bash
#
# Shared helpers sourced by the setup scripts.

# Print a formatted, spaced message.
fancy_echo() {
    local message="$1"; shift
    # shellcheck disable=SC2059
    printf "\n$message\n" "$@"
}

# Return success when running in a CI environment.
is_ci() {
    [[ -n "${CI:-}" ]]
}

# Ensure Homebrew is on PATH for the current shell (Apple Silicon or Intel).
load_brew_shellenv() {
    if command -v brew >/dev/null 2>&1; then
        eval "$(brew shellenv)"
    elif [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}