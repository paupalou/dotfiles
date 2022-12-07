require('onedarkpro').setup({
  cache = true,
  plugins = {
    all = false,
    native_lsp = true,
    treesitter = true,
    aerial = true,
    gitsigns = true,
    neo_tree = true,
    nvim_bqf = true,
    nvim_cmp = true,
    packer = true,
    startify = true,
    trouble = true,
    which_key = true
  }
})
vim.cmd([[ syntax on ]])
vim.cmd([[ colorscheme onedarkpro ]])

vim.o.termguicolors = true
vim.o.background = 'dark'

local M = {
  base00 = '#1b2b34',
  base01 = '#343d46',
  base02 = '#4f5b66',
  base03 = '#65737e',
  base04 = '#a7adba',
  base05 = '#c0c5ce',
  base06 = '#cdd3de',
  base07 = '#d8dee9',
  red = '#ec5f67',
  orange = '#f99157',
  yellow = '#fac863',
  green = '#99c794',
  cyan = '#62b3b2',
  blue = '#6699cc',
  purple = '#c594c5',
  brown = '#ab7967',
  white = '#ffffff',
}

local highlights = {
  Comment = { fg = 'gray', italic = true },

  NormalFloat =  { bg = '#1b2b34' },
  FloatBorder = { fg = '#f99157' },

  PmenuSel = { bg = M.base01, fg = 'NONE' },
  Pmenu = { fg = '#C5CDD9', bg = '#22252A' },

  CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
  CmpItemAbbrMatch = { fg = '#82AAFF', bg = 'NONE', bold = true },
  CmpItemAbbrMatchFuzzy = { fg = '#82AAFF', bg = 'NONE', bold = true },
  CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },

  CmpItemKindField = { fg = '#EED8DA', bg = '#B5585F' },
  CmpItemKindProperty = { fg = '#EED8DA', bg = '#B5585F' },
  CmpItemKindEvent = { fg = '#EED8DA', bg = '#B5585F' },

  CmpItemKindText = { fg = '#C3E88D', bg = '#9FBD73' },
  CmpItemKindEnum = { fg = '#C3E88D', bg = '#9FBD73' },
  CmpItemKindKeyword = { fg = '#C3E88D', bg = '#9FBD73' },

  CmpItemKindConstant = { fg = '#FFE082', bg = '#D4BB6C' },
  CmpItemKindConstructor = { fg = '#FFE082', bg = '#D4BB6C' },
  CmpItemKindReference = { fg = '#FFE082', bg = '#D4BB6C' },

  CmpItemKindFunction = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindStruct = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindClass = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindModule = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindOperator = { fg = '#EADFF0', bg = '#A377BF' },

  CmpItemKindVariable = { fg = '#C5CDD9', bg = '#7E8294' },
  CmpItemKindFile = { fg = '#C5CDD9', bg = '#7E8294' },

  CmpItemKindUnit = { fg = '#F5EBD9', bg = '#D4A959' },
  CmpItemKindSnippet = { fg = '#F5EBD9', bg = '#D4A959' },
  CmpItemKindFolder = { fg = '#F5EBD9', bg = '#D4A959' },

  CmpItemKindMethod = { fg = '#DDE5F5', bg = '#6C8ED4' },
  CmpItemKindValue = { fg = '#DDE5F5', bg = '#6C8ED4' },
  CmpItemKindEnumMember = { fg = '#DDE5F5', bg = '#6C8ED4' },

  CmpItemKindInterface = { fg = '#D8EEEB', bg = '#58B5A8' },
  CmpItemKindColor = { fg = '#D8EEEB', bg = '#58B5A8' },
  CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = '#58B5A8' },

  -- Fillchars
  VertSplit = { fg = '#22252A' },
  WinSeparator = { fg = '#22252A' },

  -- Treesitter context
  TreesitterContext = { bg = M.base01 },
  TreesitterContextLineNumber = { bg = M.base01 }
}

for hiGroup, color in pairs(highlights) do
  vim.api.nvim_set_hl(0, hiGroup, color)
end

return M
