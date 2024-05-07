--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

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
      disabled_filetypes = {
        statusline = { "alpha" },
      },
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        ---@diagnostic disable-next-line: param-type-mismatch
        { "mode", fmt=trunc(80, 4, nil, true) },
      },
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
    extensions = { "lazy", "mason", "fzf", "neo-tree", "quickfix", "aerial" },
    winbar = {},
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
        ---@diagnostic disable-next-line: need-check-nil
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
    vim.keymap.set("n", "<leader>g", "<cmd>:FzfLua live_grep<CR>", { desc = "FzfLua - Find in project", silent = true })
    vim.keymap.set(
      "n",
      "<leader>*",
      "<cmd>:FzfLua grep_cword<CR>",
      { desc = "FzfLua - Grep word under cursor", silent = true }
    )
  end,
  opts = {
    'default-title',
    defaults = {
      formatter = "path.filename_first"
    },
    winopts = {
      win_height = 0.60,
      win_width = 0.40,
    },
    preview_opts = "",
    preview_vertical = "nohidden",
    preview_horizontal = "nohidden",
    fzf_colors = {
      ["fg"]          = { "fg", "CursorLine" },
      ["bg"]          = { "bg", "Normal" },
      ["hl"]          = { "fg", "Comment" },
      ["fg+"]         = { "fg", "Normal" },
      ["bg+"]         = { "bg", "CursorLine" },
      ["hl+"]         = { "fg", "Statement" },
      ["info"]        = { "fg", "PreProc" },
      ["prompt"]      = { "fg", "Conditional" },
      ["pointer"]     = { "fg", "Exception" },
      ["marker"]      = { "fg", "Keyword" },
      ["spinner"]     = { "fg", "Label" },
      ["header"]      = { "fg", "Comment" },
      ["gutter"]      = { "bg", "Normal" },
    },
    hls = {
      header_bind = "PreProc"
    }
  },
}

local ufo = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
  },
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
    open_fold_hl_timeout = 400,
    close_fold_kinds_for_ft = { "imports", "comment" },
    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
      },
    },
  },
  init = function()
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.cmd([[highlight FoldColumn guibg=#242933]])
  end,
  -- stolen from https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1514537245
  config = function(_, opts)
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local totalLines = vim.api.nvim_buf_line_count(0)
      local foldedLines = endLnum - lnum
      local suffix = (" 󱥤 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
      suffix = (" "):rep(rAlignAppndx) .. suffix
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end
    opts["fold_virt_text_handler"] = handler
    require("ufo").setup(opts)
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.cmd([[ Lspsaga hover_doc ]])
      end
    end)
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
  {
    "echasnovski/mini.statusline",
    enabled = false,
    version = false,
    config = function()
      require("mini.statusline").setup()
    end
  },
  fzf,
  ufo,
  alpha,
}
