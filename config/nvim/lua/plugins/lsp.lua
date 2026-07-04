return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/lazydev.nvim", ft = "lua" },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					-- "codebook",
					"ruff",
				},
			})
			require("mason-null-ls").setup({
				ensure_installed = {
					"codelldb",
					"clang-format",
					"cmakelint",
					"cpplint",
					"stylua",
					"eslit-lsp",
					"lua-language-server",
					-- "prettier",
					-- "typescript-language-server"
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end

				map("n", "<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("n", "<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("n", "<leader>gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("n", "<leader>gr", vim.lsp.buf.references, "[G]oto [R]eferences")
				map("n", "<leader>gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
				map("n", "K", vim.lsp.buf.hover, "Hover")
			end

			vim.lsp.config("clangd", { capabilities = capabilities, on_attach = on_attach })
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			})
			vim.lsp.config("pyright", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							typeCheckingMode = "off",
						},
					},
				},
			})
			vim.lsp.config("ruff", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.hoverProvider = false
					on_attach(client, bufnr)
				end,
			})

			vim.diagnostic.config({
				virtual_text = { spacing = 2, prefix = "●" },
				float = { border = "rounded" },
				severity_sort = true,
			})
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-neo-tree/neo-tree.nvim" },
		opts = {},
	},
}
