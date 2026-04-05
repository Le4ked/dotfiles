# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for an Arch Linux system, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package mirroring `$HOME` — `stow <package>` creates symlinks from the package tree into `~`.

## Applying configs

```bash
# Install dependencies and stow all packages (Arch/pacman)
bash stow.sh

# Stow a single package
stow -d ~/dotfiles -t ~ nvim

# Re-stow after adding files to a package
stow -R -d ~/dotfiles -t ~ <package>

# Remove symlinks for a package
stow -D -d ~/dotfiles -t ~ <package>
```

## Package → config path mapping

| Package | Destination |
|---|---|
| `ghostty` | `~/.config/ghostty/config.ghostty` |
| `nvim` | `~/.config/nvim/` |
| `yazi` | `~/.config/yazi/` |
| `zellij` | `~/.config/zellij/config.kdl` |
| `zsh` | `~/.zshrc` |

## Known issue in stow.sh

`ghostty` and `zsh` are missing from the `packages` array — they get installed by pacman but never stowed:

```bash
# current (broken)
packages=(nvim yazi zellij)

# should be
packages=(nvim yazi zellij ghostty zsh)
```

## Neovim config

See `nvim/.config/nvim/CLAUDE.md` for full details (plugin inventory, keybindings, LSP setup).

- Plugin manager: `lazy.nvim` — add a plugin by dropping a new file in `lua/plugins/`
- LSP servers managed by Mason — add to `servers` table in `lua/plugins/nvim-lspconfig.lua`
- Leader: `<Space>`, localleader: `\`

## Zellij config

`config.kdl` uses `keybinds clear-defaults=true` — the full keybind set is explicit, nothing inherited from Zellij defaults. Mode entry keys: Pane `Ctrl w/p`, Tab `Ctrl t`, Resize `Ctrl n`, Scroll `Ctrl s`, Move `Ctrl h`, Session `Ctrl o`, Tmux `Ctrl b`, Locked `Ctrl g`.
