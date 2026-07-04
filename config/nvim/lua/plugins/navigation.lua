return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live grep",
			},
		},
		opts = {},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		config = function()
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
		cmd = { "Neotree" },
		keys = { { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" } },
		opts = {
			filesystem = {
				filtered_items = { hide_dotfiles = false, hide_gitignored = false, never_show = { ".git" } },
				follow_current_file = { enabled = true },
			},
			window = { position = "right", width = 40 },
		},
		lazy = false,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		event = "VeryLazy",
		opts = {
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				bo = { filetype = { "neo-tree", "neo-tree-popup", "notify" }, buftype = { "terminal", "quickfix" } },
			},
		},
	},
}
