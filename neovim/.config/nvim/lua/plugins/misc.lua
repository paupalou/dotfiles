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
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")
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
    config = function()
      require("block").setup({})
    end,
  },
}
