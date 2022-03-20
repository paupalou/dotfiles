local bufferline = require('bufferline')
local MAPPER = require('utils')

MAPPER.nnoremap(']b', '<cmd>:BufferLineCycleNext<CR>')
MAPPER.nnoremap('[b', '<cmd>:BufferLineCyclePrev<CR>')
MAPPER.nnoremap('<leader>c', '<cmd>:Bdelete<CR>')

MAPPER.nnoremap('<leader>1', '<cmd>:BufferLineGoToBuffer 1<CR>')
MAPPER.nnoremap('<leader>2', '<cmd>:BufferLineGoToBuffer 2<CR>')
MAPPER.nnoremap('<leader>3', '<cmd>:BufferLineGoToBuffer 3<CR>')
MAPPER.nnoremap('<leader>4', '<cmd>:BufferLineGoToBuffer 4<CR>')
MAPPER.nnoremap('<leader>5', '<cmd>:BufferLineGoToBuffer 5<CR>')
MAPPER.nnoremap('<leader>6', '<cmd>:BufferLineGoToBuffer 6<CR>')
MAPPER.nnoremap('<leader>7', '<cmd>:BufferLineGoToBuffer 7<CR>')
MAPPER.nnoremap('<leader>8', '<cmd>:BufferLineGoToBuffer 8<CR>')
MAPPER.nnoremap('<leader>9', '<cmd>:BufferLineGoToBuffer 9<CR>')

bufferline.setup{
  options = {
    numbers = function(opts)
      return string.format('%s.', opts.ordinal)
    end,
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    }
  },
  highlights = {
    fill = {
      guibg = '#002b34',
    },
  }
}
