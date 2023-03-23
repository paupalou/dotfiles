local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

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
      lualine_b = {
        { "macro-recording", fmt = show_macro_recording },
      },
      lualine_c = {
        { "filename", path = 1 },
      },
      lualine_x = {
        "filetype",
      },
    },
    extensions = { "fzf", "neo-tree", "quickfix", "aerial" },
  },
  init = function()
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh({
          place = { "statusline" },
        })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            require("lualine").refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })
  end,
}

local fzf = {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "FzfLua",
  init = function()
    vim.keymap.set("n", "<leader><space>", "<cmd>:FzfLua<CR>", { desc = "FzfLua", silent = true })
    vim.keymap.set("n", "<leader>f", "<cmd>:FzfLua files<CR>", { desc = "FzfLua - Find files", silent = true })
    vim.keymap.set("n", "<leader>b", "<cmd>:FzfLua buffers<CR>", { desc = "FzfLua - Find buffers", silent = true })
    vim.keymap.set(
      "n",
      "<leader>*",
      "<cmd>:FzfLua grep_cword<CR>",
      { desc = "FzfLua - Grep word under cursor", silent = true }
    )
  end,
  opts = {
    winopts = {
      win_height = 0.50,
      win_width = 0.60,
    },
    preview_opts = "",
    preview_vertical = "nohidden:down:45%",
    preview_horizontal = "nohidden:right:60%",
  },
}

local ufo = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    -- {
    --   "luukvbaal/statuscol.nvim",
    --   config = function()
    --     local builtin = require("statuscol.builtin")
    --
    --     require("statuscol").setup({
    --       -- relculright = true,
    --       -- segments = {
    --       --   { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
    --       --   { text = { "%s" }, click = "v:lua.ScSa" },
    --       --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
    --       -- },
    --     })
    --   end,
    -- },
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
  "goolord/alpha-nvim",
  config = function()
    require("alpha").setup(require("alpha.themes.startify").config)
  end,
}

return {
  {
    "chentoast/marks.nvim",
    opts = {},
  },
  lualine,
  fzf,
  ufo,
  alpha,
}
