return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"nvim-neotest/nvim-nio",
		{
			"rcarriga/nvim-dap-ui",
			config = true,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			config = true,
		},
	},

	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dap.defaults.fallback.external_terminal = {
			command = "tmux",
			args = { "split-window", "-h", "-d", "-p", "45" },
		}

		dap.defaults.fallback.force_external_terminal = true

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,

	keys = {
		{
			"<leader>db",
			function()
				vim.cmd.DapToggleBreakpoint()
			end,
			desc = "[D]AP Toggle [B]reakpoint",
		},

		{
			"<leader>dc",
			function()
				vim.cmd.DapContinue()
			end,
			desc = "[D]AP [C]ontinue",
		},

		{
			"<leader>dd",
			function()
				vim.cmd.DapNew()
			end,
			desc = "[D]AP Start [D]ebug",
		},
	},

	cmd = {
		"DapContinue",
		"DapLoadLaunchJSON",
		"DapRestartFrame",
		"DapSetLogLevel",
		"DapShowLog",
		"DapStepInto",
		"DapStepOut",
		"DapStepOver",
		"DapTerminate",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapVirtualTextDisable",
		"DapVirtualTextEnable",
		"DapVirtualTextForceRefresh",
		"DapVirtualTextToggle",
	},

	lazy = true,
}
