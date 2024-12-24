require("defaults")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					return {
						CursorLine = { bg = colors.crust },
					}
				end,
			})
			vim.cmd([[colorscheme catppuccin-latte]])
		end,
	},
	{ import = "plugins" },
}, {
	colorscheme = "catpuccin-latte",
	install = {
		colorscheme = { "catppuccin-latte" },
	},
})
