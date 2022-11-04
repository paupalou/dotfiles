local MAPPER = require('utils')
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup()

MAPPER.map(MAPPER.MODES.NORMAL, '<C-n>', '<cmd>:Neotree toggle<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>n', '<cmd>:Neotree reveal<CR>')
