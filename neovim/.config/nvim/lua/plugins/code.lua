local lsp = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "ray-x/lsp_signature.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    {
      "glepnir/lspsaga.nvim",
      event = "BufRead",
      config = function()
        require("lspsaga").setup({
          ui = {
            title = false,
            border = "rounded",
          },
          symbol_in_winbar = {
            enable = false,
          },
          lightbulb = {
            enable = false,
          },
        })
      end,
    },
    {
      "NvChad/nvim-colorizer.lua",
      opts = {
        user_default_options = {
          tailwind = true,
        },
      },
    },
  },
  config = function()
    local on_attach = function(_, bufnr)
      require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- fix_pos = true,
        floating_window = false,
        hint_enable = true,
        hint_prefix = "🔧 ",
        hi_parameter = "LspSignatureSearch",
        auto_close_after = 2,
        handler_opts = {
          border = "rounded",
          max_width = 90,
          max_height = 70,
        },
      }, bufnr)

      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[n]ame")
      nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
      nmap("<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostic")
      nmap("gd", "<cmd>Lspsaga goto_definition<CR>", "[G]oto [D]efinition")
      nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "[P]eek Definition")
      nmap("gr", "<cmd>Lspsaga lsp_finder<CR>", "[G]oto [R]eferences")
      nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
      nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to prev [D]iagnostic")
      nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next [D]iagnostic")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local servers = {
      rust_analyzer = {},
      tsserver = {},
      tailwindcss = {},
      pyright = {},

      lua_ls = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }

    require("neodev").setup()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason").setup()
    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })
    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
          },
        })
      end,
    })

    local null_ls = require("null-ls")

    local sources = {
      -- formatters
      null_ls.builtins.formatting.eslint_d,
      -- null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci" },
      }),
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.json_tool,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.sqlformat,
      null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      }),
      -- null_ls.builtins.formatting.deno_fmt,

      -- diagnostics
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
      }),
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.luacheck.with({
        extra_args = { "--config ~/.config/luacheck/.luacheckrc" },
      }),
      -- null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort.with({
        extra_args = {
          "--profile",
          "black",
          "--trailing-comma",
          "-o",
          "utils",
        },
      }),

      -- code actions
      null_ls.builtins.code_actions.eslint_d,
    }

    null_ls.setup({ sources = sources })
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
}

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    ensure_installed = {
      "lua",
      "python",
      "rust",
      "vim",
      "fish",
      "html",
      "json",
      "markdown",
      "python",
      "typescript",
      "tsx",
      "javascript"
    },
    highlight = { enable = true },
    indent = { enable = false },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
  ---@diagnostic disable-next-line: unused-local
  config = function(plugin, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

local aerial = {
  "stevearc/aerial.nvim",
  cmd = "AerialToggle",
  keys = {
    { "]a", "<cmd>:AerialToggle<CR>", desc = "Aerial Toggle" },
  },
  config = true,
}

local barbecue = {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    show_dirname = false,
    theme = {
      normal = { bg = "#111625" },
    },
  },
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  init = function()
    local gitsigns = require("gitsigns")
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gitsigns.next_hunk()
      end)
      return "<Ignore>"
    end, { desc = "GitSigns - Next hunk", silent = true })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[gc"
      end
      vim.schedule(function()
        gitsigns.prev_hunk()
      end)
      return "<Ignore>"
    end, { desc = "GitSigns - Prev hunk", silent = true })
    vim.keymap.set("n", "]p", gitsigns.preview_hunk, { desc = "GitSigns - Preview hunk", silent = true })
    vim.keymap.set(
      "n",
      "]t",
      gitsigns.toggle_current_line_blame,
      { desc = "GitSigns - Toggle line blame", silent = true }
    )
    vim.keymap.set("n", "]h", gitsigns.diffthis, { desc = "GitSigns - Diff this", silent = true })
    vim.keymap.set("n", "]H", function()
      require("gitsigns").diffthis("~")
    end, { desc = "GitSigns - Diff this ~", silent = true })
  end,
  config = true,
}

return {
  lsp,
  treesitter,
  aerial,
  barbecue,
  gitsigns,
}
