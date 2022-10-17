vim.o.shell = '/bin/bash'
vim.o.showmatch = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.updatetime = 50
vim.o.showmode = false
vim.o.showcmd = false
vim.o.cmdheight = 1
vim.o.scrolloff = 8
vim.o.clipboard = 'unnamedplus'
vim.o.incsearch = true
vim.o.inccommand = 'split'
vim.o.signcolumn = 'auto'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.mouse = 'nvr'
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·'
vim.o.laststatus = 3
vim.o.foldlevel = 99

---- Fillchars
vim.opt.fillchars:append({
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
})

-- folds
vim.wo.foldcolumn = '0'
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- avoid hit-enter prompts
vim.cmd [[ set shortmess+=c ]]

-- leader
vim.g.mapleader = ' '
