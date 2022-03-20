local MAPPER = require 'utils'

MAPPER.nnoremap('<C-n>', '<cmd> :NvimTreeToggle<CR>')
MAPPER.nnoremap('<leader>r', '<cmd> :NvimTreeRefresh<CR>')
MAPPER.nnoremap('<leader>n', '<cmd> :NvimTreeFindFile<CR>')
