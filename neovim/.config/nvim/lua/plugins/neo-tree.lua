local MAPPER = require('utils')
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  close_if_last_window = true
})

MAPPER.map(MAPPER.MODES.NORMAL, '<C-n>', '<cmd>:Neotree toggle<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>n', '<cmd>:Neotree reveal<CR>')
