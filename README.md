# Dotfiles

Personal macOS dotfiles that bootstrap a full development environment:
symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions,
and the Fish shell. Managed with [Dotbot](https://github.com/anishathalye/dotbot).

## Installation

Clone the repository and run the install script:

```sh
git clone https://github.com/gianlukk994/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

`./install` syncs the `dotbot` submodule and applies `install.conf.yaml`, which:

1. Creates symlinks into `$HOME` (`~/.config`, `~/.gitconfig`,
   `~/.gitignore_global`, `~/.vimrc`, `~/.asdfrc`, and the VS Code
   `settings.json`).
2. Runs the setup scripts in order:
   `setup_homebrew.sh` → `setup_macos.sh` → `setup_asdf.sh` →
   `setup_vscode.sh` → `setup_fish.sh`.

### Running a single step

Each setup script is standalone and can be re-run on its own:

```sh
./setup_homebrew.sh   # Install/update Homebrew + Brewfile packages
./setup_macos.sh      # Apply macOS defaults and Dock config
./setup_asdf.sh       # Install asdf plugins and language runtimes
./setup_vscode.sh     # Install VS Code extensions
./setup_fish.sh       # Set Fish as default shell, install Oh My Fish
```

## Structure

| Path | Purpose |
| --- | --- |
| `install` / `install.conf.yaml` | Dotbot entry point and symlink/script config. |
| `Brewfile` | Homebrew formulae and casks (`brew bundle`). |
| `vscode_extension.txt` | VS Code extensions installed by `setup_vscode.sh`. |
| `.config/fish/` | Fish config; aliases and env in `config.fish`. |
| `.config/nvim/` | Neovim config built on [LazyVim](https://www.lazyvim.org/). |
| `.config/starship.toml` | Starship prompt config. |
| `.gitconfig`, `.gitignore_global` | Git configuration. |
| `.asdfrc`, `.tool-versions` | asdf runtime manager config and pinned versions. |
| `vscode/` | VS Code `settings.json` and custom CSS. |
| `dotbot/` | Dotbot submodule (do not edit directly). |

## Conventions

- **Colorscheme:** Catppuccin Mocha across Neovim, Starship, and git colors.
- **Runtimes:** pinned in `.tool-versions` and managed with asdf.
- **Git:** commits are GPG-signed by default; `push.autoSetupRemote` is on.

## Adding things

- **Packages:** add to `Brewfile`, then run `brew bundle`.
- **Symlinks:** add an entry under `link:` in `install.conf.yaml`, then
  re-run `./install`.
- **VS Code extensions:** add the extension id to `vscode_extension.txt`.

## Notes

- Secrets (`.env`, `google_api.json`) and the `github-copilot` config are
  gitignored and never committed.
