return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
	},
	keys = {
		{ "<leader>dc", function() require("dap").continue() end, desc = "Start/Continue debugging" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "Re-run last debug config" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Stop debug session" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		-- Auto open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- C / C++ / Rust via lldb-dap
		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-dap",
			name = "lldb",
		}

		local lldb_config = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Attach to process",
				type = "lldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
			},
		}

		dap.configurations.c = lldb_config
		dap.configurations.cpp = lldb_config
		dap.configurations.rust = lldb_config

		-- Python via debugpy
		dap.adapters.python = {
			type = "executable",
			command = "python3",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				name = "Launch file",
				type = "python",
				request = "launch",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				name = "Launch file with arguments",
				type = "python",
				request = "launch",
				program = "${file}",
				args = function()
					local input = vim.fn.input("Arguments: ")
					return vim.split(input, " ", { trimempty = true })
				end,
				cwd = "${workspaceFolder}",
			},
		}

		-- Go via delve
		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		dap.configurations.go = {
			{
				name = "Launch file",
				type = "delve",
				request = "launch",
				program = "${file}",
			},
			{
				name = "Launch package",
				type = "delve",
				request = "launch",
				program = "${workspaceFolder}",
			},
			{
				name = "Launch test",
				type = "delve",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				name = "Attach to process",
				type = "delve",
				request = "attach",
				mode = "local",
				pid = require("dap.utils").pick_process,
			},
		}
	end,
}
