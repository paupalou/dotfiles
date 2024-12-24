return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/trouble.nvim",
	},
	cmd = "FzfLua",
	init = function()
		vim.keymap.set("n", "<leader><space>", "<cmd>:FzfLua<CR>", { desc = "FzfLua", silent = true })
		vim.keymap.set("n", "<leader>f", "<cmd>:FzfLua files<CR>", { desc = "FzfLua - Find files", silent = true })
		vim.keymap.set("n", "<leader>b", "<cmd>:FzfLua buffers<CR>", { desc = "FzfLua - Find buffers", silent = true })
		vim.keymap.set(
			"n",
			"<leader>g",
			"<cmd>:FzfLua live_grep<CR>",
			{ desc = "FzfLua - Find in project", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>*",
			"<cmd>:FzfLua grep_cword<CR>",
			{ desc = "FzfLua - Grep word under cursor", silent = true }
		)

		local config = require("fzf-lua.config")
		local actions = require("trouble.sources.fzf").actions
		config.defaults.actions.files["ctrl-t"] = actions.open
	end,
	opts = {
		"default-title",
		-- defaults = {
		--     formatter = "path.filename_first",
		-- },
		winopts = {
			height = 0.60,
			width = 0.60,
			preview = {
				hidden = "hidden",
			},
		},
		fzf_colors = {
			["fg"] = { "fg", "CursorLine" },
			["bg"] = { "bg", "Normal" },
			["hl"] = { "fg", "Comment" },
			["fg+"] = { "fg", "Normal" },
			["bg+"] = { "bg", "CursorLine" },
			["hl+"] = { "fg", "Statement" },
			["info"] = { "fg", "PreProc" },
			["prompt"] = { "fg", "Conditional" },
			["pointer"] = { "fg", "Exception" },
			["marker"] = { "fg", "Keyword" },
			["spinner"] = { "fg", "Label" },
			["header"] = { "fg", "Comment" },
			["gutter"] = { "bg", "Normal" },
		},
		hls = {
			header_bind = "PreProc",
		},
	},
}
