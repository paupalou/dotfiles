local Utils = require("utils")

return {
	{
		"max397574/better-escape.nvim",
		opts = {
			default_mappings = false,
			mappings = {
				i = {
					j = { k = "<Esc>" },
					k = { j = "<Esc>" },
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},
	{
		"aserowy/tmux.nvim",
		keys = {
			"<C-h>",
			"<C-j>",
			"<C-k>",
			"<C-l>",
			"<M-h>",
			"<M-j>",
			"<M-k>",
			"<M-l>",
		},
		config = function()
			require("tmux").setup({
				copy_sync = {
					sync_registers = false,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		tag = "v3.8.2",
		config = function()
			-- vim.opt.list = true
			-- vim.opt.listchars:append("eol:↴")
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "InactiveBlankline", { fg = "#ccd0da" })
				vim.api.nvim_set_hl(0, "ActiveBlankline", { fg = "#bcc0cc" })
			end)
			local opts = {
				indent = {
					char = "┆",
					highlight = { "InactiveBlankline" },
				},
				scope = {
					char = "▏",
					highlight = { "ActiveBlankline" },
				},
			}
			require("ibl").setup(opts)
		end,
	},
	{
		"utilyre/sentiment.nvim",
		name = "sentiment",
		version = "*",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.jump",
		version = false,
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.move",
		version = false,
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode
					left = "<S-Left>",
					right = "<S-Right>",
					down = "<S-Down>",
					up = "<S-Up>",
					-- Move current line in Normal mode
					line_left = "<S-Left>",
					line_right = "<S-Right>",
					line_down = "<S-Down>",
					line_up = "<S-Up>",
				},
			})
		end,
	},
	{
		"HampusHauffman/block.nvim",
		keys = {
			"<leader>z",
		},
		config = function()
			require("block").setup({})
			vim.keymap.set("n", "<leader>z", "<cmd>:Block<CR>", { desc = "[Block] Show code blocks", silent = true })
		end,
	},
	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0, vertical = 0 },
				},
				render = function(props)
					local devicons = require("nvim-web-devicons")
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local res = {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = Utils.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						guibg = "#69D2E7",
					}
					table.insert(res, " ")
					return res
				end,
			})
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = "*",
		config = function()
			require("mini.bracketed").setup({
				comment = { suffix = "g", options = {} },
				treesitter = { suffix = "", options = {} },
			})
		end,
	},
}
