local MAPPER = require 'utils'

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>q', function ()
  local buffer_filetype = vim.bo.filetype
  if buffer_filetype == 'qf' or buffer_filetype == '' then
    return '<cmd>bdelete<CR>'
  else
    return '<cmd>Bdelete<CR>'
  end
end, { expr = true })

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>Q', '<cmd>qa!<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>x', '<cmd>q<CR>')

MAPPER.map(MAPPER.MODES.NORMAL, '<c-s>', '<cmd>:w<CR>')

MAPPER.map(MAPPER.MODES.INSERT, '<c-a>', '<esc>I')
MAPPER.map(MAPPER.MODES.INSERT, '<c-e>', '<esc>A')
MAPPER.map(MAPPER.MODES.INSERT, '<c-s>', '<esc><cmd>:w<CR>')
