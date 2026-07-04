return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue",
			},
			{
				"<F9>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<F3>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<F4>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<F6>",
				function()
					local dap = require("dap")
					local dapui = require("dapui")
					dap.terminate()
					dap.close()
					dapui.close()
				end,
				desc = "DAP Stop",
			},
			{
				"<F1>",
				function()
					require("dap").up()
				end,
				desc = "DAP Stack Up",
			},
			{
				"<F2>",
				function()
					require("dap").down()
				end,
				desc = "DAP Stack Down",
			},
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {},
				automatic_setup = false,
				handlers = {},
			})

			local dap, dapui = require("dap"), require("dapui")
			dap.defaults.codelldb.exception_breakpoints = {}

			local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
				enrich_config = function(cfg, on_config)
					cfg.evaluateForHovers = true
					cfg.variablePresentation = {
						includeChildVariables = true,
						includeAll = true,
					}
					on_config(cfg)
				end,
			}

			local source_map = {
				["/build"] = vim.loop.cwd(),
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					evaluateForHovers = true,
					showDisassembly = "never",
					sourceMap = source_map,

					initCommands = {
						"process handle -s true -n true -p false SIGSEGV",
						"settings set target.process.thread.step-avoid-regexp 'libc\\\\.|libstdc\\\\+\\\\+\\\\.|ld-linux|libpthread|libgcc_s|llvm|clang'",
					},
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			dapui.setup({
				layouts = {
					{
						position = "left",
						size = 50,
						elements = {
							{ id = "scopes", size = 0.38 },
							{ id = "stacks", size = 0.28 },
							{ id = "watches", size = 0.16 },
						},
					},
					{
						position = "bottom",
						size = 10, -- lines
						elements = { "repl", "console" },
					},
				},
				controls = { enabled = true, element = "repl" },
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
