local cmp = require('cmp')
local lspkind = require('lspkind')

local cmdline_formatting = { fields = { "abbr" } }
local winhighlight = cmp.config.window.bordered({
  winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  formatting = cmdline_formatting,
  window = {
    completion = winhighlight,
  },
  sources = {
    { name = 'path' },
    { name = 'cmdline' }
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  formatting = cmdline_formatting,
  window = {
    completion = winhighlight,
  },
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true),
          ''
        )
      else
        return
        -- fallback()
      end
    end, { "i", "s" }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. strings[1] .. " "
      kind.menu = "    (" .. strings[2] .. ")"

      return kind
    end,
  },
  window = {
    documentation = winhighlight,
    completion = {
      winhighlight,
      col_offset = -3,
      side_padding = 0,
    },
  },
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
  }
})
