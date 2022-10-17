local MAPPER = require 'utils'
require('nvim-tree').setup({
  filters = {
    custom = { '.git', 'node_modules', '.cache', '.github', '.vscode' }
  }
})

MAPPER.map(MAPPER.MODES.NORMAL, '<C-n>', '<cmd> :NvimTreeToggle<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>r', '<cmd> :NvimTreeRefresh<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>n', '<cmd> :NvimTreeFindFile<CR>')

vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★',
    deleted = '',
    ignored = '◌',
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}
