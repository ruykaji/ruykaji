return {
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		ft = { "c", "cpp", "cmake" },
		opts = {
			cmake_use_preset = true,

			cmake_compile_commands_options = { action = "soft_link", target = vim.loop.cwd() },

			cmake_executor = {
				name = "quickfix",
				opts = { show = "always", auto_close_when_success = true },
			},

			cmake_runner = {
				name = "quickfix",
				opts = { show = "always", auto_close_when_success = true },
			},
		},
		keys = {
			{ "<leader>cB", "<cmd>CMakeSelectBuildPreset<CR>", desc = "Select build preset" },
			{ "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "Build (current preset)" },
			{ "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", desc = "Select build target" },
			{ "<leader>cl", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "Select launch target" },
			{ "<leader>cr", "<cmd>CMakeRun<CR>", desc = "Run launch target" },
			{ "<leader>cd", "<cmd>CMakeDebug<CR>", desc = "Debug launch target" },
		},
	},
}
