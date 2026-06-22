# Dotfiles

Personal macOS dotfiles that bootstrap a full development environment:
symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions,
and the Fish shell. Symlinks are managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

Clone the repository, install the packages, then stow the dotfiles:

```sh
git clone https://github.com/gianlukk994/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 1. Install Homebrew packages (includes stow)
./setup_homebrew.sh

# 2. Symlink the dotfiles into $HOME
stow -d stow -t ~ git vim asdf fish nvim gh starship

# 3. Run the remaining setup steps
./setup_macos.sh
./setup_asdf.sh
./setup_vscode.sh
./setup_fish.sh
```

Each `setup_*.sh` script is standalone and can be re-run on its own.

## Stow usage

The `stow/` directory holds one package per tool. Every package mirrors the
layout of `$HOME`, so stowing a package symlinks its files into the right place.

```sh
# Link a single package
stow -d stow -t ~ nvim

# Link everything
stow -d stow -t ~ git vim asdf fish nvim gh starship

# Preview without touching the filesystem
stow -n -v -d stow -t ~ nvim

# Remove a package's symlinks
stow -D -d stow -t ~ nvim

# Re-link after adding or moving files in a package
stow -R -d stow -t ~ nvim
```

`~/.config` is a real directory: stowed packages create per-tool symlinks
inside it (`~/.config/fish`, `~/.config/nvim`, …) while leaving untracked app
state untouched.

## Structure

| Path                    | Purpose                                                     |
| ----------------------- | ----------------------------------------------------------- |
| `stow/`                 | Stow packages, one per tool (each mirrors `$HOME`).         |
| `Brewfile`              | Homebrew formulae and casks (`brew bundle`).                |
| `vscode_extension.txt`  | VS Code extensions installed by `setup_vscode.sh`.          |
| `stow/fish/`            | Fish config; aliases and env in `config.fish`.              |
| `stow/nvim/`            | Neovim config built on [LazyVim](https://www.lazyvim.org/). |
| `stow/starship/`        | Starship prompt config.                                     |
| `stow/git/`             | Git configuration.                                          |
| `stow/asdf/`            | asdf runtime manager config.                                |
| `vscode/`               | VS Code `settings.json` and custom CSS.                     |

## Conventions

- **Colorscheme:** Catppuccin Mocha across Neovim, Starship, and git colors.
- **Runtimes:** pinned in `.tool-versions` and managed with asdf.
- **Git:** commits are GPG-signed by default; `push.autoSetupRemote` is on.

## Adding things

- **Packages:** add to `Brewfile`, then run `brew bundle`.
- **Dotfiles:** add the file inside the matching `stow/<package>/` tree
  (mirroring its `$HOME` path), then re-run `stow -R -d stow -t ~ <package>`.
- **A new tool:** create `stow/<tool>/` mirroring `$HOME`, then stow it.
- **VS Code extensions:** add the extension id to `vscode_extension.txt`.

## Notes

- Secrets (`.env`, `google_api.json`) and the `github-copilot` config are
  gitignored and never committed.
