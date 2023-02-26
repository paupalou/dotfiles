local MAPPER = require 'utils'
vim.g.minimap_auto_start = 1
vim.g.minimap_git_colors = 1

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>m', '<cmd> :MinimapToggle<CR>')
