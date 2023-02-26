local lualine = {
  "hoob3rt/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = "catppuccin",
    },
    sections = {
      lualine_c = {
        { "filename", path = 1 }
      },
      lualine_x = {
        "filetype"
      }
    },
    extensions = { "fzf", "neo-tree", "quickfix", "aerial" },
  },
}

local fzf = {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  cmd = "FzfLua",
  init = function()
    vim.keymap.set("n", "<leader><space>", "<cmd>:FzfLua<CR>", { desc = "FzfLua", silent = true })
    vim.keymap.set("n", "<leader>f", "<cmd>:FzfLua files<CR>", { desc = "FzfLua - Find files", silent = true })
    vim.keymap.set("n", "<leader>b", "<cmd>:FzfLua buffers<CR>", { desc = "FzfLua - Find buffers", silent = true })
    vim.keymap.set("n", "<leader>*", "<cmd>:FzfLua grep_cword<CR>", { desc = "FzfLua - Grep word under cursor", silent = true })
  end,
  opts = {
    winopts = {
      win_height = 0.50,
      win_width = 0.60,
    },
    preview_opts = '',
    preview_vertical = 'nohidden:down:45%',
    preview_horizontal = 'nohidden:right:60%',
  }
}

local ufo = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      opts = {
        foldfunc = "builtin",
        setopt = true,
      },
    },
  },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  },
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,
}

local alpha = {
  'goolord/alpha-nvim',
  config = function ()
    require'alpha'.setup(require'alpha.themes.startify'.config)
  end
}


return {
  {
    "chentoast/marks.nvim",
    opts = {},
  },
  lualine,
  fzf,
  ufo,
  alpha
}
