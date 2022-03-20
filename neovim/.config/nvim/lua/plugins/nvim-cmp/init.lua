local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = function()
      if vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true),
          ''
        )
      else
        return
        -- fallback()
      end
    end,
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        path = '[Path]',
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        vsnip = '[Snippet]',
      })[entry.source.name]
      return vim_item
    end,
  },
  documentation = {
    border = 'rounded',
    winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder',
    maxwidth = 90,
    maxheight = 70,
  },
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
  },
})
