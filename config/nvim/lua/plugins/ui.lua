return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		lazy = false,
		config = function()
			vim.o.background = "dark"
			vim.g.gruvbox_material_background = "soft"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_transparent_background = 2

			mode = "day"

			if mode == "night" then
				-- Nightblue colors
				vim.g.gruvbox_material_colors_override = {
					-- Pallete 1 background
					bg_dim = { "#0f1318", "232" },
					bg0 = { "#14171d", "233" },
					bg1 = { "#171c24", "234" },
					bg2 = { "#1b2230", "235" },
					bg3 = { "#232a38", "236" },
					bg4 = { "#2a3344", "237" },
					bg5 = { "#323c52", "239" },
					bg_statusline1 = { "#171c24", "234" },
					bg_statusline2 = { "#1b2230", "235" },
					bg_statusline3 = { "#2a3344", "237" },
					bg_visual_red = { "#2b1f25", "52" },
					bg_visual_yellow = { "#2b241d", "94" },
					bg_visual_green = { "#1f2b24", "22" },
					bg_visual_blue = { "#182236", "17" },
					bg_visual_purple = { "#241f34", "54" },
					bg_diff_red = { "#24161a", "52" },
					bg_diff_green = { "#17271f", "22" },
					bg_diff_blue = { "#16243a", "17" },
					bg_current_word = { "#232a38", "236" },

					-- Pallete 2 foreground
					fg0 = { "#c4cfe0", "252" },
					fg1 = { "#aeb9c9", "250" },
					red = { "#d17b83", "167" },
					orange = { "#c8926f", "173" },
					yellow = { "#c9b27f", "179" },
					green = { "#78b29a", "108" },
					aqua = { "#76aeb8", "109" },
					blue = { "#7aa0d1", "110" },
					purple = { "#a88fe0", "140" },
					bg_red = { "#d17b83", "167" },
					bg_green = { "#78b29a", "108" },
					bg_yellow = { "#c9b27f", "179" },

					-- Pallete 3
					grey0 = { "#606e7a", "243" },
					grey1 = { "#7f8d98", "245" },
					grey2 = { "#9eaab6", "247" },
					none = { "NONE", "NONE" },
				}
			end

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { options = { theme = "auto", section_separators = "", component_separators = "" } },
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		opts = {},
	},
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			views = {
				notify = {
					timeout = 250,
					replace = true,
					merge = true,
				},
			},
		},
	},
}
