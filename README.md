# Dotfiles

Personal macOS dotfiles that bootstrap a full development environment:
symlinks, Homebrew packages, macOS defaults, asdf runtimes, VS Code extensions,
the Fish shell, and the WezTerm terminal. Symlinks are managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Installation

Clone the repository:

```sh
git clone https://github.com/gianlukk994/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Setup

> You need an SSH key added to your GitHub account to clone/pull private
> repos.

```sh
cp stow/wezterm/.config/wezterm/local.lua.example stow/wezterm/.config/wezterm/local.lua
```

`setup/github-repos.sh` (run by `bootstrap.sh`) clones repos declared in
`repos.toml` using `gh`. Copy `repos.toml.example` to `repos.toml`
(gitignored) and fill it in:

```sh
cp repos.toml.example repos.toml
```

```toml
base_dir = "~/Projects"

[Personal.gianlukk994]
repos = ["dotfiles", "some-side-project"]

[Work.acme-corp]
repos = ["backend-api", "frontend-app"]
```

`base_dir` is the root folder repos are cloned into (defaults to
`~/Projects` if omitted). `Destination` is any top-level folder name under
`base_dir`. The script creates `<base_dir>/<Destination>/<org-or-username>/`
and clones missing repos into it. Requires `gh` installed and authenticated; no-op in CI or if
`repos.toml` is missing.

Now run the bootstrap script:

```sh
./bootstrap.sh
```

`bootstrap.sh` installs the Homebrew packages (including `stow`), symlinks the
dotfiles with Stow, and runs the setup scripts.

To run a single step manually:

```sh
./setup/homebrew.sh                          # Homebrew + Brewfile packages
stow -d stow -t ~ git vim asdf fish nvim gh starship vscode wezterm   # symlink dotfiles
./setup/macos.sh                             # macOS defaults and Dock
./setup/asdf.sh                              # asdf runtimes from ~/.tool-versions
./setup/fish.sh                              # default shell + Oh My Fish
./setup/ambit.sh                             # install the ambit binary
./setup/github-repos.sh                      # clone repos listed in repos.toml
```

## Stow usage

The `stow/` directory holds one package per tool. Every package mirrors the
layout of `$HOME`, so stowing a package symlinks its files into the right place.

```sh
# Link a single package
stow -d stow -t ~ nvim

# Link everything
stow -d stow -t ~ git vim asdf fish nvim gh starship vscode wezterm

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

| Path                    | Purpose                                                          |
| ----------------------- | ----------------------------------------------------------------- |
| `bootstrap.sh`          | Entry point: installs packages, stows dotfiles, runs setup.       |
| `setup/`                | Individual setup scripts (homebrew, macos, asdf, fish, ambit, vscode, github-repos). |
| `repos.toml.example`    | Example config for `setup/github-repos.sh` (copy to `repos.toml`).|
| `lib/utils.sh`          | Shared shell helpers sourced by the setup scripts.                |
| `stow/`                 | Stow packages, one per tool (each mirrors `$HOME`).               |
| `Brewfile`              | Homebrew formulae, casks, App Store and VS Code apps.             |
| `stow/fish/`            | Fish config; aliases and env in `config.fish`.                    |
| `stow/nvim/`            | Neovim config built on [LazyVim](https://www.lazyvim.org/).       |
| `stow/starship/`        | Starship prompt config.                                           |
| `stow/git/`             | Git configuration.                                                |
| `stow/asdf/`            | asdf runtime manager config.                                      |
| `stow/vscode/`          | VS Code `settings.json` and custom CSS.                           |
| `stow/wezterm/`         | WezTerm terminal config (`wezterm.lua`).                          |

## Conventions

- **Colorscheme:** Catppuccin Mocha across Neovim, Starship, and git colors;
  Tokyo Night in WezTerm (tab bar, window frame, and integrated title buttons).
- **Runtimes:** managed with asdf; `setup/asdf.sh` installs the versions
  pinned in `~/.tool-versions` if that file exists.
- **Git:** commits are GPG-signed by default; `push.autoSetupRemote` is on.

## WezTerm

The `stow/wezterm/` package holds `~/.config/wezterm/wezterm.lua` (Tokyo Night
theme, fancy tab bar, split/pane keybindings). Machine-local details (e.g. SSH
hosts) live in a gitignored `local.lua` — copy `local.lua.example` to
`local.lua` and fill it in.

## ambit

[ambit](https://github.com/nebulab/ambit) is a dependency manager for AI
agent skills, hooks, and MCP servers (Claude Code, Codex, Cursor, opencode,
VS Code). `setup/ambit.sh` installs the `ambit` binary if it's missing.

`~/ambit.yml` (the project config) and `~/.agents/` (generated state, e.g.
`.skill-lock.json`) are **not** tracked here — they can reference private
catalogs or machine-local paths. On a fresh machine, recreate `~/ambit.yml`
by hand (or `ambit init`), then run `ambit install`.

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
