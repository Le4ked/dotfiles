return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
	keys = {
		{"<leader>e", "<cmd>Neotree filesystem reveal float toggle<cr>", desc = "Toggle Explorer"},
		{"<leader>E", "<cmd>Neotree filesystem left reveal toggle<cr>", desc = "Side Explorer"},
		{"<leader>b", "<cmd>Neotree buffers float<cr>", desc = "Buffer Overview"},
		{"<leader>g", "<cmd>Neotree git_status float<cr>", desc = "Git Overview"},
		{"<leader>G", "<cmd>Neotree filesystem current toggle<cr>", desc = "Open Expolorer in current Window"},
	}
}
