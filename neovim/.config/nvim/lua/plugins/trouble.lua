return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	config = function()
		require("trouble").setup()
		vim.keymap.set(
			"n",
			"]t",
			"<cmd>lua require('trouble').next({ jump = true })<CR>",
			{ desc = "Trouble next item", silent = true }
		)
		vim.keymap.set(
			"n",
			"[t",
			"<cmd>lua require('trouble').prev({ jump = true })<CR>",
			{ desc = "Trouble prev item", silent = true }
		)
	end,
}
