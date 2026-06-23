# Dotfiles

Personal macOS dotfiles that bootstrap a full development environment:
symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions,
and the Fish shell. Symlinks are managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

Clone the repository and run the bootstrap script:

```sh
git clone https://github.com/gianlukk994/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs the Homebrew packages (including `stow`), symlinks the
dotfiles with Stow, and runs the setup scripts.

To run a single step manually:

```sh
./setup/homebrew.sh                          # Homebrew + Brewfile packages
stow -d stow -t ~ git vim asdf fish nvim gh starship vscode   # symlink dotfiles
./setup/macos.sh                             # macOS defaults and Dock
./setup/asdf.sh                              # asdf runtimes from ~/.tool-versions
./setup/fish.sh                              # default shell + Oh My Fish
```

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
| `bootstrap.sh`          | Entry point: installs packages, stows dotfiles, runs setup. |
| `setup/`                | Individual setup scripts (homebrew, macos, asdf, fish).     |
| `lib/utils.sh`          | Shared shell helpers sourced by the setup scripts.          |
| `stow/`                 | Stow packages, one per tool (each mirrors `$HOME`).         |
| `Brewfile`              | Homebrew formulae, casks, App Store and VS Code apps.       |
| `stow/fish/`            | Fish config; aliases and env in `config.fish`.              |
| `stow/nvim/`            | Neovim config built on [LazyVim](https://www.lazyvim.org/). |
| `stow/starship/`        | Starship prompt config.                                     |
| `stow/git/`             | Git configuration.                                          |
| `stow/asdf/`            | asdf runtime manager config.                                |
| `stow/vscode/`          | VS Code `settings.json` and custom CSS.                     |

## Conventions

- **Colorscheme:** Catppuccin Mocha across Neovim, Starship, and git colors.
- **Runtimes:** managed with asdf; `setup/asdf.sh` installs the versions
  pinned in `~/.tool-versions` if that file exists.
- **Git:** commits are GPG-signed by default; `push.autoSetupRemote` is on.

## Adding things

- **Packages, casks, App Store and VS Code apps:** install them with `brew`
  wherever you like, then snapshot the system into the `Brewfile` (see below).
- **Dotfiles:** add the file inside the matching `stow/<package>/` tree
  (mirroring its `$HOME` path), then re-run `stow -R -d stow -t ~ <package>`.
- **A new tool:** create `stow/<tool>/` mirroring `$HOME`, then stow it.
- **VS Code:** edit files under `stow/vscode/Library/Application Support/Code/User/`.

## Brewfile workflow

The `Brewfile` is the single source of truth for Homebrew formulae, casks,
Mac App Store apps (`mas`) and VS Code extensions (`vscode`). Rather than
installing from the repo, just install whatever you want with `brew` directly.

The Fish config wraps `brew` so the `Brewfile` is re-dumped automatically after
a successful `brew install`/`uninstall`/`tap`/`untap`/`reinstall`, capturing
the new formulae, casks, `mas` and VS Code apps. The wrapper only updates the
file — review and commit the change yourself. Run `brewdump` to refresh it on
demand (for example after installing a cask or extension outside of `brew`).

To restore everything on a fresh machine, `bootstrap.sh` runs
`brew bundle` for you (or run `brew bundle --file=~/.dotfiles/Brewfile`).

## Notes

- Secrets (`.env`, `google_api.json`) and the `github-copilot` config are
  gitignored and never committed.
