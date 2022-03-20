local MAPPER = require 'utils'

MAPPER.nnoremap('<leader>q', '<cmd>q<CR>')
MAPPER.nnoremap('<leader>Q', '<cmd>qa!<CR>')

MAPPER.nnoremap('<leader>v', '<C-w>v')
MAPPER.nnoremap('<leader>h', '<C-w>s')

MAPPER.nnoremap('<leader>h', '<C-w>s')
MAPPER.nnoremap('<c-s>', '<cmd>:w<CR>')

MAPPER.inoremap('<c-a>', '<esc>I')
MAPPER.inoremap('<c-e>', '<esc>A')
MAPPER.inoremap('<c-s>', '<esc><cmd>:w<CR>')
