return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	opts = {
		interactions = {
			chat = {
				adapter = {
					name = "anthropic",
					model = "claude-sonnet-4-6",
				},
			},
			inline = {
				adapter = "anthropic",
			},
			cmd = {
				adapter = "anthropic",
			},
			background = {
				adapter = "anthropic",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
