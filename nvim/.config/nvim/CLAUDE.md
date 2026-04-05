# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All config is written in Lua.

## Architecture

- `init.lua` — entry point: sets global options (tabs=4, line numbers, true color), disables netrw, then loads `config.lazy` and `config.keymapping`
- `lua/config/lazy.lua` — bootstraps lazy.nvim, sets `<Space>` as leader/`\` as localleader, auto-imports everything under `lua/plugins/`
- `lua/config/keymapping.lua` — global keymaps not tied to a specific plugin
- `lua/plugins/` — one file per plugin (or related group). Each returns a lazy.nvim plugin spec table.

**Adding a plugin:** create a new file in `lua/plugins/` returning a valid lazy.nvim spec. It will be auto-discovered.

**Adding keymaps:** global ones go in `keymapping.lua`; plugin-specific ones go in the plugin's `keys = {}` table or inside its `config` function.

## Plugin inventory

| Category | Plugin |
|---|---|
| File tree | `neo-tree.nvim` |
| Fuzzy finder | `telescope.nvim` + `telescope-fzf-native` + `recent_files` extension |
| LSP | `nvim-lspconfig` + `mason` + `mason-lspconfig` + `mason-tool-installer` + `fidget.nvim` |
| Completion | `blink.cmp` + `LuaSnip` + `lazydev.nvim` |
| Formatting | `conform.nvim` (auto-format on save; `stylua` for Lua) |
| Syntax | `nvim-treesitter` |
| Statusline | `lualine.nvim` |
| Theme | `tokyonight.nvim` (variant: `tokyonight-night`) |
| Icons | `mini.icons` |
| Motion | `comfortable-motion` |
| Editing | `autoclose.nvim`, `todo-comments.nvim`, `which-key` |

## Key bindings (leader = `<Space>`)

**Telescope**
- `<leader><leader>` — fuzzy find in current buffer
- `<leader>ff/fg/fb/fh/fc/ft/fk/fo/fr` — find files / live grep / buffers / help / commands / colorscheme / keymaps / old files / recent files

**Neo-tree**
- `<leader>e` — floating file explorer
- `<leader>E` — left-side file explorer
- `<leader>b` — buffer overview
- `<leader>g` — git status
- `<leader>G` — explorer in current window

**LSP** (active when an LSP attaches)
- `grn` — rename, `gra` — code action, `grr` — references, `grd` — definition, `gri` — implementation, `grD` — declaration, `grt` — type definition
- `gO` — document symbols, `gW` — workspace symbols

**Other**
- `<leader>=` — format buffer (conform.nvim)
- `<leader>w` — window prefix (`<C-w>`)
- `<leader>c` — open terminal; `<Esc><Esc>` exits terminal mode
- `<leader>tt/tw/tq/tl/th` — new tab / buffer in tab / close tab / next tab / prev tab
- `<A-.>/<A-,>` — next/prev tab (alt key variants)
- `<Esc><Esc>` (normal mode) — clear search highlight

## LSP setup

LSP servers are managed by Mason. To add a new language server, add it to the `servers` table in `lua/plugins/nvim-lspconfig.lua`. Mason will auto-install it on next Neovim start.

Currently explicitly configured: `lua_ls`. `stylua` is auto-installed for Lua formatting.

`<C-ö>` accepts a completion (German keyboard layout).

## Notes

- `lua_line.lua` at the repo root is a stale/unused file — not loaded by anything.
- `lua/plugins/avante.lua` was deleted (see git status); avante is no longer part of this config.
- Inlay hints toggle: `<leader>lh` in `nvim-lspconfig.lua`.
