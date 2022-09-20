require 'lualine'.setup{
  options = {
    theme = 'catppuccin',
    globalstatus= true,
  },
  sections = {
    lualine_a = {
      { 'mode', icons_enabled = true },
    },
    lualine_c = {
      { 'filename', path = 3, padding = 2 }
    },
    lualine_x = {
      { 'filetype' }
    }
  },
  extensions = { 'fzf', 'nvim-tree', 'quickfix' }
}
