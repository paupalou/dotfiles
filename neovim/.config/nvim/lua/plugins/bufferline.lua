local bufferline = require('bufferline')
local MAPPER = require('utils')

MAPPER.map(MAPPER.MODES.NORMAL, ']b', '<cmd>:BufferLineCycleNext<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '[b', '<cmd>:BufferLineCyclePrev<CR>')

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>1', function () bufferline.go_to_buffer(1, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>2', function () bufferline.go_to_buffer(2, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>3', function () bufferline.go_to_buffer(3, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>4', function () bufferline.go_to_buffer(4, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>5', function () bufferline.go_to_buffer(5, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>6', function () bufferline.go_to_buffer(6, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>7', function () bufferline.go_to_buffer(7, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>8', function () bufferline.go_to_buffer(8, true) end)
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>9', function () bufferline.go_to_buffer(9, true) end)

bufferline.setup{
  options = {
    numbers = "ordinal",
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
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = "",
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

