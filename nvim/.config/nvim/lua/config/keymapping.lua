-- Telescope Commands
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope commands" })
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Telescope themes" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })
vim.keymap.set(
	"n",
	"<leader>fr",
	[[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
	{ noremap = true, silent = true },
	{ desc = "Telescope recent files" }
)
-- Window
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window prefix" })
--Terminal
vim.keymap.set("n", "<leader>c", "<cmd>terminal<cr>", { desc = "Open Terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true }, { desc = "Open Terminal" })
-- LSP
vim.keymap.set("n", "<leader>lf", "<cmd>vim.lsp.buf.format()<cr>", { desc = "Format buffer" })
-- Tabs
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tw", "<cmd>tab split<cr>", { desc = "Buffer in new Tab" })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Close current Tab" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Terminal Quit

vim.keymap.set("n", "<Esc><Esc>", "<cmd>noh<cr>", { noremap = true }, { desc = "Clear Search" })
-- Tab Alt Commands
vim.keymap.set("n", "<A-.>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<A-,>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<A-w>", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<A-t>", "<cmd>tabnew<cr>", { desc = "New Tab" })

vim.keymap.set("n", "<A-l>", "<C-]>", { desc = "Follow Link" })

-- NOTE:  Noch mehr Keybinds in der nvim-lspconfig.lua unter /plugins
