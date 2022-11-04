local MAPPER = require('utils')
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  source_selector = {
    winbar = true,
    statusline = false
  }
})

MAPPER.map(MAPPER.MODES.NORMAL, '<C-n>', '<cmd>:Neotree<CR>')

require('aerial').setup()
