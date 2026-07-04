local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("lazy").setup({
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.core" },
		{ import = "plugins.folding" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.lsp" },
		{ import = "plugins.completion" },
		{ import = "plugins.format" },
		{ import = "plugins.debug" },
		{ import = "plugins.cmake" },
		{ import = "plugins.git" },
		{ import = "plugins.navigation" },
	},
	install = { colorscheme = { "gruvbox-material" } },
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
require("config.keymaps")
