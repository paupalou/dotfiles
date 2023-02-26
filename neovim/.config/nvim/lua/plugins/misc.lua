return {
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
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "┊",
      space_char_blankline = " ",
      show_current_context = true,
    },
    init = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")
    end,
  },
  {
    "echasnovski/mini.jump",
    version = false,
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
}
