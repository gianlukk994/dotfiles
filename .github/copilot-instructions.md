# Copilot Instructions

## Overview

This is a macOS dotfiles repository managed by [Dotbot](https://github.com/anishathalye/dotbot). It bootstraps a full development environment: symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions, and Fish shell configuration.

## Setup & Installation

Run the top-level install script to apply everything:

```sh
./install
```

This executes `install.conf.yaml`, which:
1. Creates symlinks (`~/.config` → `.config`, `~/.gitconfig`, `~/.gitignore_global`, `~/.vimrc`, `~/.asdfrc`, VS Code `settings.json`)
2. Runs setup scripts in order: `setup_homebrew.sh` → `setup_macos.sh` → `setup_asdf.sh` → `setup_vscode.sh` → `setup_fish.sh`

To run a single setup step:

```sh
./setup_homebrew.sh   # Install/update Homebrew + Brewfile packages
./setup_macos.sh      # Apply macOS defaults and Dock config
./setup_asdf.sh       # Install asdf plugins and runtimes from .tool-versions
./setup_vscode.sh     # Install VS Code extensions
./setup_fish.sh       # Set Fish as default shell, install Oh My Fish
```

## Architecture

- **`install.conf.yaml`** — Dotbot config; single source of truth for which files get symlinked and which scripts run.
- **`Brewfile`** — All Homebrew formulae and casks. Edit here, then run `brew bundle`.
- **`.config/fish/`** — Fish shell config. `config.fish` holds all aliases, `PATH` extensions, and environment variables. Custom functions live in `functions/`.
- **`.config/nvim/`** — Neovim config built on [LazyVim](https://www.lazyvim.org/). Plugins declared in `lua/plugins/`, core config in `lua/config/`.
- **`.config/starship.toml`** — Starship prompt config.
- **`dotbot/`** — Git submodule; do not edit directly.

## Key Conventions

### Colorscheme: Catppuccin Mocha
The same palette is used across all tools — Neovim (`lua/plugins/colorscheme.lua`), Starship (`starship.toml`), and git diff/status/branch colors (`.gitconfig`). When adding a new tool, configure it with Catppuccin Mocha.

### Version Management: asdf
Runtime versions are pinned in `.tool-versions`. Currently `ruby 3.1.4`. Add new language versions here rather than installing globally.

### Git
- Commits are GPG-signed by default (`commit.gpgSign = true` in `.gitconfig`). Signing key: `6DDC77D977223AAA`.
- `push.autoSetupRemote = true` — no need to set upstream on first push.
- The `gsnap` Fish function does a quick `git add . && git commit -m snap --no-verify` for WIP snapshots.

### Adding New Symlinks
Add entries under the `link:` section in `install.conf.yaml`, then re-run `./install`.

### Adding New Packages
Add to `Brewfile`, then run `brew bundle` (or re-run `./setup_homebrew.sh`).

### Fish Aliases / Functions
- Short git aliases (`gch`, `gpl`, `gps`, etc.) live in `config.fish`.
- Multi-line logic belongs in `functions/<name>.fish`.
- `direnv` is hooked in automatically for `.envrc` support.
