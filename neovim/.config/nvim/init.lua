require("defaults")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    enable = false,
    config = function()
      local palette = require("nordic.colors")
      require("nordic").load({
        override = {
          FoldColumn = {
            bg = palette.gray0,
          },
          FloatBorder = {
            bg = palette.gray0,
            fg = palette.orange.base,
          },
          NormalFloat = {
            bg = palette.gray0,
          },
        },
      })
    end,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {},
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  { import = "plugins" },
}, { colorscheme = "catpuccin-latte" })

vim.cmd[[colorscheme catppuccin-latte]]
