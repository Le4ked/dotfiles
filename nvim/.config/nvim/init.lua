--nvim-tree - disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- True color
vim.opt.termguicolors = true

require("config.lazy")

require("config.keymapping")

-- Settings
--
vim.opt.cursorline = true
-- Line number
vim.wo.number = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Mouse activation
vim.g.mouse = "a"

vim.opt.encoding = "utf-8"

-- Scroll off aktivieren
-- vim.opt.scrolloff = 7

-- Tab Spacing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
