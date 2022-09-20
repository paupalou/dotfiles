local MAPPER = require 'utils'

vim.keymap.set('n', '<Leader>q', function ()
  return vim.bo.filetype == 'qf' and '<cmd>bdelete<CR>' or '<cmd>Bdelete<CR>'
end, { expr = true })

MAPPER.nnoremap('<leader>Q', '<cmd>Bdelete!<CR>')

MAPPER.nnoremap('<leader>v', '<C-w>v')
MAPPER.nnoremap('<leader>h', '<C-w>s')

MAPPER.nnoremap('<leader>h', '<C-w>s')
MAPPER.nnoremap('<c-s>', '<cmd>:w<CR>')

MAPPER.inoremap('<c-a>', '<esc>I')
MAPPER.inoremap('<c-e>', '<esc>A')
MAPPER.inoremap('<c-s>', '<esc><cmd>:w<CR>')
