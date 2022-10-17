local MAPPER = require 'utils'

vim.keymap.set('n', '<Leader>q', function ()
  return vim.bo.filetype == 'qf' and '<cmd>bdelete<CR>' or '<cmd>Bdelete<CR>'
end, { expr = true })

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>Q', '<cmd>qa!<CR>')

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>v', '<C-w>v')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>h', '<C-w>s')

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>h', '<C-w>s')
MAPPER.map(MAPPER.MODES.NORMAL, '<c-s>', '<cmd>:w<CR>')

MAPPER.map(MAPPER.MODES.INSERT, '<c-a>', '<esc>I')
MAPPER.map(MAPPER.MODES.INSERT, '<c-e>', '<esc>A')
MAPPER.map(MAPPER.MODES.INSERT, '<c-s>', '<esc><cmd>:w<CR>')
