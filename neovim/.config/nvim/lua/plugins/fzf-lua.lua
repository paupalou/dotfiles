local MAPPER = require('utils')
local fzf_lua = require('fzf-lua')

fzf_lua.setup({
  winopts = {
    win_height = 0.50,
    win_width = 0.60,
  },
  preview_opts = '',
  preview_vertical = 'nohidden:down:45%',
  preview_horizontal = 'nohidden:right:60%',
})

MAPPER.nnoremap('<leader>f', '<cmd> :FzfLua files<CR>')
MAPPER.nnoremap('<leader>b', '<cmd> :FzfLua buffers<CR>')
