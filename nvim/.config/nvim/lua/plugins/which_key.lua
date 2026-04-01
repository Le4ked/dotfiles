return {
		{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
	config = function()
			require("which-key").add({
		{"<leader>f", group = "find", icon={icon="󰭎"} },
		{"<leader>B", group = "Buffer options", icon={icon=""}},
		{"<leader>Bo", group = "Buffer order by ...", icon={icon="󰈞"}},
			})
		end
}
}
