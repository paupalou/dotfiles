local bufferline = require('bufferline')
local MAPPER = require('utils')

MAPPER.map(MAPPER.MODES.NORMAL, ']b', '<cmd>:BufferLineCycleNext<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '[b', '<cmd>:BufferLineCyclePrev<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>c', '<cmd>:Bdelete<CR>')

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>1', '<cmd>:BufferLineGoToBuffer 1<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>2', '<cmd>:BufferLineGoToBuffer 2<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>3', '<cmd>:BufferLineGoToBuffer 3<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>4', '<cmd>:BufferLineGoToBuffer 4<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>5', '<cmd>:BufferLineGoToBuffer 5<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>6', '<cmd>:BufferLineGoToBuffer 6<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>7', '<cmd>:BufferLineGoToBuffer 7<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>8', '<cmd>:BufferLineGoToBuffer 8<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>9', '<cmd>:BufferLineGoToBuffer 9<CR>')

bufferline.setup{
  options = {
    numbers = 'ordinal',
    show_close_icon = false,
    buffer_close_icon = "",
    modified_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      icon = '┃ ', -- this should be omitted if indicator style is not 'icon'
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      }
    },
    separator_style = { '','' },
  },
  highlights = {
    fill = {
      bg = '#002b34',
    },
    indicator_selected = {
      fg = '#FFE082',
    },
  }
}

