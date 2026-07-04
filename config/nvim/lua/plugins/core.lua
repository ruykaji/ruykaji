return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{
		"Pocco81/auto-save.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			trigger_events = { "InsertLeave", "TextChanged" },
			debounce_delay = 135,
			execution_message = {
				cleaning_interval = 250,
			},
		},
	},
}
