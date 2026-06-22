# Copilot Instructions

## Overview

This is a macOS dotfiles repository whose symlinks are managed by [GNU Stow](https://www.gnu.org/software/stow/). It bootstraps a full development environment: symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions, and Fish shell configuration.

## Setup & Installation

Run the bootstrap script to apply everything:

```sh
./bootstrap.sh
```

This:
1. Installs Homebrew and the `Brewfile` packages (including `stow`).
2. Symlinks the dotfiles with `stow -d stow -t ~ git vim asdf fish nvim gh starship` and links the VS Code `settings.json`.
3. Runs setup scripts in order: `setup_homebrew.sh` → `setup_macos.sh` → `setup_asdf.sh` → `setup_vscode.sh` → `setup_fish.sh`

To run a single setup step:

```sh
./setup_homebrew.sh   # Install/update Homebrew + Brewfile packages
./setup_macos.sh      # Apply macOS defaults and Dock config
./setup_asdf.sh       # Install asdf plugins and runtimes from .tool-versions
./setup_vscode.sh     # Install VS Code extensions
./setup_fish.sh       # Set Fish as default shell, install Oh My Fish
```

## Architecture

- **`bootstrap.sh`** — Entry point; installs packages, runs Stow, and runs the setup scripts.
- **`stow/`** — Stow packages, one per tool (`git`, `vim`, `asdf`, `fish`, `nvim`, `gh`, `starship`). Each package mirrors `$HOME`.
- **`Brewfile`** — All Homebrew formulae and casks. Edit here, then run `brew bundle`.
- **`stow/fish/.config/fish/`** — Fish shell config. `config.fish` holds all aliases, `PATH` extensions, and environment variables. Custom functions live in `functions/`.
- **`stow/nvim/.config/nvim/`** — Neovim config built on [LazyVim](https://www.lazyvim.org/). Plugins declared in `lua/plugins/`, core config in `lua/config/`.
- **`stow/starship/.config/starship.toml`** — Starship prompt config.

## Key Conventions

### Colorscheme: Catppuccin Mocha
The same palette is used across all tools — Neovim (`stow/nvim/.config/nvim/lua/plugins/colorscheme.lua`), Starship (`stow/starship/.config/starship.toml`), and git diff/status/branch colors (`stow/git/.gitconfig`). When adding a new tool, configure it with Catppuccin Mocha.

### Version Management: asdf
Runtime versions are pinned in `.tool-versions`. Currently `ruby 3.1.4`. Add new language versions here rather than installing globally.

### Git
- Commits are GPG-signed by default (`commit.gpgSign = true` in `stow/git/.gitconfig`). Signing key: `6DDC77D977223AAA`.
- `push.autoSetupRemote = true` — no need to set upstream on first push.
- The `gsnap` Fish function does a quick `git add . && git commit -m snap --no-verify` for WIP snapshots.

### Adding New Dotfiles / Symlinks
Add the file inside the matching `stow/<package>/` tree (mirroring its `$HOME` path), then run `stow -R -d stow -t ~ <package>`. For a new tool, create `stow/<tool>/` mirroring `$HOME` and stow it.

### Adding New Packages
Add to `Brewfile`, then run `brew bundle` (or re-run `./setup_homebrew.sh`).

### Fish Aliases / Functions
- Short git aliases (`gch`, `gpl`, `gps`, etc.) live in `config.fish`.
- Multi-line logic belongs in `functions/<name>.fish`.
- `direnv` is hooked in automatically for `.envrc` support.
