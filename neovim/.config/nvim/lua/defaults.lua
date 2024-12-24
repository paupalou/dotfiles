-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- disable wrap
vim.o.wrap = false
-- breakindent
vim.o.breakindent = true

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- true colors
vim.o.termguicolors = true

-- don't load the plugins below
local builtins = {
	"gzip",
	"zip",
	"zipPlugin",
	"fzf",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"matchit",
	"matchparen",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end

-- avoid hit-enter prompts
vim.cmd([[ set shortmess+=c ]])

vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.completeopt = "menu,menuone,noselect"
vim.o.showmode = false
vim.o.showcmd = false
vim.o.cmdheight = 0
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 8
vim.o.inccommand = "split"
vim.o.laststatus = 3

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better close buffer/quit handling
vim.keymap.set("n", "<leader>q", function()
	local buffer_filetype = vim.bo.filetype
	if buffer_filetype == "qf" or buffer_filetype == "" then
		return "<cmd>bdelete<CR>"
	else
		return "<cmd>Bdelete<CR>"
	end
end, { desc = "BuffDelete - Close buffer", expr = true, silent = true })

vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Close all buffers (force)", silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>q<CR>", { desc = "Close buffer", silent = true })

-- Save files with CTRL-s
vim.keymap.set({ "n", "i" }, "<c-s>", "<cmd>w<CR>", { silent = true })

-- Start / End of line CTRL-a CTRL-e
vim.keymap.set("i", "<c-a>", "<esc>I", { silent = true })
vim.keymap.set("i", "<c-e>", "<esc>A", { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- disable swapfiles and backups
vim.o.swapfile = false
vim.o.backup = false

vim.o.statusline = "%#Normal#"

vim.g.python3_host_prog = "~/.virtualenvs/neovim/bin/python3"
vim.g.python_host_prog = "~/.virtualenvs/neovim/bin/python"

vim.filetype.add({
	extension = {
		j2 = "html",
	},
})

vim.diagnostic.config({
	virtual_text = false,
	float = {
		border = "rounded",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󱤅",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

vim.opt.listchars = {
	tab = "▸ ",
	trail = "·",
	precedes = "←",
	extends = "→",
}
vim.opt.list = true
