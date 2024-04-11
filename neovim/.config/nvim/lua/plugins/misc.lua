local Colors = {}

---@class RGBColor
---@field r number a number between 0 and 1 inclusive
---@field g number a number between 0 and 1 inclusive
---@field b number a number between 0 and 1 inclusive

---@alias HexColor string a hex color string

---@alias Color RGBColor|HexColor

---Check if a color is a hex color. Leading # is optional.
---@param color unknown
---@return boolean
local is_hex_color = function(color)
  return type(color) == 'string' and color:match '^#?%x%x%x%x%x%x$'
end

local is_rgb_color = function(color)
  return type(color) == 'table'
    and type(color.r) == 'number'
    and type(color.g) == 'number'
    and type(color.b) == 'number'
end

---Convert a hex string to an RGB color
---@param color Color
---@return RGBColor
Colors.hex_to_rgb = function(color)
  if is_rgb_color(color) then
    ---@type RGBColor
    return color
  end
  assert(is_hex_color(color), 'color must be a hex color')
  assert(type(color) == 'string', 'color must be a string') -- for type checking
  local hex = color:gsub('#', ''):lower()
  return {
    r = tonumber(hex:sub(1, 2), 16) / 255,
    g = tonumber(hex:sub(3, 4), 16) / 255,
    b = tonumber(hex:sub(5, 6), 16) / 255,
  }
end

---Convert an RGBColor to a HexColor
---@param rgb RGBColor
---@return HexColor
Colors.rgb_to_hex = function(rgb)
  local function to_hex(channel)
    local hex = string.format('%x', math.floor(channel * 255))
    if #hex == 1 then
      hex = '0' .. hex
    end
    return hex
  end
  return '#' .. to_hex(rgb.r) .. to_hex(rgb.g) .. to_hex(rgb.b)
end

---Given a color, return its relative luminance
---@param color Color
Colors.relative_luminance = function(color)
  local rgb = Colors.hex_to_rgb(color)
  local r, g, b = rgb.r, rgb.g, rgb.b
  local function adjust(channel)
    if channel <= 0.03928 then
      return channel / 12.92
    else
      return ((channel + 0.055) / 1.055) ^ 2.4
    end
  end
  r, g, b = adjust(r), adjust(g), adjust(b)
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

---@class ContrastColorOptions
---@field dark? Color (default '#000000')
---@field light? Color (default '#ffffff')
---@field threshold? number (default 0.179)

---Given a color, return either a dark or light color depending on the
---relative luminance of the input color.
---@param color Color
---@param opts? ContrastColorOptions
---@return Color
Colors.contrast_color = function(color, opts)
  opts = opts or {}
  local dark = opts.dark or '#000000'
  local light = opts.light or '#ffffff'
  local threshold = opts.threshold or 0.179
  if Colors.relative_luminance(Colors.hex_to_rgb(color)) > threshold then
    return dark
  else
    return light
  end
end


return {
  {
    "max397574/better-escape.nvim",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "aserowy/tmux.nvim",
    keys = {
      "<C-h>",
      "<C-j>",
      "<C-k>",
      "<C-l>",
      "<M-h>",
      "<M-j>",
      "<M-k>",
      "<M-l>",
    },
    config = function()
      require("tmux").setup({
        copy_sync = {
          sync_registers = false,
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "InactiveBlankline", { fg = "#ccd0da" })
        vim.api.nvim_set_hl(0, "ActiveBlankline", { fg = "#bcc0cc" })
      end)
      local opts = {
        indent = {
          char = "┆",
          highlight = { "InactiveBlankline" },
        },
        scope = {
          char =  "▏",
          highlight = { "ActiveBlankline" },
        },
      }
      require("ibl").setup(opts)
    end,
  },
  {
    "utilyre/sentiment.nvim",
    name = "sentiment",
    version = "*",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.jump",
    version = false,
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode
          left = "<S-Left>",
          right = "<S-Right>",
          down = "<S-Down>",
          up = "<S-Up>",
          -- Move current line in Normal mode
          line_left = "<S-Left>",
          line_right = "<S-Right>",
          line_down = "<S-Down>",
          line_up = "<S-Up>",
        },
      })
    end,
  },
  {
    "HampusHauffman/block.nvim",
    keys = {
      "<leader>z",
    },
    config = function()
      require("block").setup({})
      vim.keymap.set("n", "<leader>z", "<cmd>:Block<CR>", { desc = "[Block] Show code blocks", silent = true })
    end,
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local devicons = require 'nvim-web-devicons'
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local res = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = Colors.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            guibg = '#69D2E7'
          }
          table.insert(res, ' ')
          return res
        end,
      })
    end,
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    config = function ()
      require('mini.bracketed').setup()
    end
  },
}
