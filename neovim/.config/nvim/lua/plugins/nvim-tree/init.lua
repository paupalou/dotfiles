require('nvim-tree').setup({
  filters = {
    custom = { '.git', 'node_modules', '.cache', '.github', '.vscode' }
  }
})

require('plugins.nvim-tree.bindings')
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
