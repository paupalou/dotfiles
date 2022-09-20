require 'plugins.lualine'
require 'plugins.betterescape'
require 'plugins.treesitter'
require 'plugins.bufferline'
require 'plugins.nvim-cmp'
require 'plugins.minimap'
require 'plugins.startify'
require 'plugins.matchup'
require 'plugins.nvim-tree'
require 'plugins.telescope'

require 'gitsigns'.setup()
require 'fidget'.setup()
local wilder = require 'wilder'
wilder.setup({ modes = { ':', '/', '?' } })
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    highlighter = wilder.basic_highlighter(),
    border = 'rounded',
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  })
))
-- wilder.set_option('renderer', wilder.popupmenu_renderer({
--   highlighter = wilder.basic_highlighter(),
--   left = { ' ', wilder.popupmenu_devicons() },
--   right = { ' ', wilder.popupmenu_scrollbar() },
-- })
-- )
require 'symbols-outline'.setup()
