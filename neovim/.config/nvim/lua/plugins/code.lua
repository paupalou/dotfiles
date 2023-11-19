local lsp = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "ray-x/lsp_signature.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        window = {
          border = "rounded",
        },
        lsp = {
          auto_attach = true,
        },
      },
    },
  },
  opts = {
    inlay_hints = { enabled = true },
  },
  config = function()
    local on_attach = function(client, bufnr)
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

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
      nmap("<leader>e", vim.diagnostic.open_float, "Show Line Diagnostic")
      nmap("gd", "<cmd>Lspsaga goto_definition<CR>", "[G]oto [D]efinition")
      nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "[P]eek Definition")
      nmap(
        "gr",
        "<cmd>lua require('fzf-lua').lsp_references({ ignore_current_line = true })<CR>",
        "[G]oto [R]eferences"
      )
      nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      -- nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Documentation")
      nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to prev [D]iagnostic")
      nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next [D]iagnostic")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(bufnr, true)
      end
    end

    local servers = {
      rust_analyzer = {},
      tsserver = {
        single_file_support = false,
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
      },
      tailwindcss = {},
      pyright = {},
      bashls = {},
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
          hint = {
            enable = true,
          },
        },
      },
      denols = {
      },
    }

    require("neodev").setup()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- require("lspconfig").denols.setup({})
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
          -- settings = servers[server_name],
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
          },
        })
      end,
      denols = function()
        require("lspconfig").denols.setup({
          cmd = { "deno", "lsp", "--unstable" },
          root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
        })
      end,
      tsserver = function()
        require("lspconfig").tsserver.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          single_file_support = false,
          root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
        })
      end,
    })

    local null_ls = require("null-ls")

    local sources = {
      -- formatters
      null_ls.builtins.formatting.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ "tsconfig.json" })
        end,
      }),
      null_ls.builtins.formatting.deno_fmt.with({
        condition = function(utils)
          return utils.root_has_file({ "deno.json" })
        end,
      }),
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

      -- diagnostics
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
        condition = function(utils)
          return utils.root_has_file({ "tsconfig.json" })
        end,
      }),
      null_ls.builtins.diagnostics.deno_lint.with({
        condition = function(utils)
          return utils.root_has_file({ "deno.json" })
        end,
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
    local signs = {
      Error = " ",
      Warn = " ",
      Info = " ",
      Hint = "󱤅 ",
      Other = "󰠠 ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
      virtual_text = false,
      float = {
        border = "rounded",
      },
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
  config = function()
    local opts = {
      ensure_installed = {
        "lua",
        "python",
        "rust",
        "vim",
        "vimdoc",
        "fish",
        "html",
        "json",
        "markdown",
        "python",
        "typescript",
        "tsx",
        "javascript",
        "bash",
      },
      highlight = { enable = true },
      indent = { enable = false },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
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
    }

    require("nvim-treesitter.install").update({ with_sync = true })
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

local comment = {
  "echasnovski/mini.comment",
  version = false,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring()
      end,
    }
    require("mini.comment").setup({ hooks })
  end,
}

local colorizer = {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "css", "scss", "typescript", "typescriptreact", "javascript", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      virtualtext = "■",
      tailwind = true,
    },
  },
}

return {
  lsp,
  treesitter,
  aerial,
  barbecue,
  gitsigns,
  comment,
  colorizer,
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
