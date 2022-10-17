local MAPPER = require('utils')

MAPPER.map(MAPPER.MODES.NORMAL, '<F1>', '<cmd> :Startify<CR>')

vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_custom_header = ''
vim.g.startify_enable_unsafe = 1
vim.g.startify_files_number = 8
vim.g.startify_session_autoload = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_bookmarks = {
  { d = '~/dotfiles' },
  { c = '~/code/' },
}
