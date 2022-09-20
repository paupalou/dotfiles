local nvim_lsp = require('lspconfig')
local typescript = require('typescript')

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function on_attach(_, bufnr)
  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- fix_pos = true,
    floating_window = false,
    hint_enable = true,
    hint_prefix = "🔧 ",
    hi_parameter = 'LspSignatureSearch',
    auto_close_after = 2,
    handler_opts = {
      border = 'rounded',
      max_width = 90,
      max_height = 70,
    },
  }, bufnr)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {
  'markdown',
  'plaintext',
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded', max_width = 90, max_height = 70 }
)
-- vim.lsp.handlers['textDocument/definition'] = goto_definition('split')

local null_ls = require('null-ls')

local sources = {
  -- formatters
  null_ls.builtins.formatting.eslint_d,
  -- null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.shfmt.with({
    extra_args = { '-i', '2', '-ci' },
  }),
  null_ls.builtins.formatting.fish_indent,
  null_ls.builtins.formatting.json_tool,
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.sqlformat,
  null_ls.builtins.formatting.stylua,
  -- null_ls.builtins.formatting.deno_fmt,
  -- diagnostics
  null_ls.builtins.diagnostics.eslint_d.with({
    diagnostics_format = '[#{c}] #{m} (#{s})',
  }),
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.luacheck,
  -- code actions
  null_ls.builtins.code_actions.eslint_d,
}

null_ls.setup({ sources = sources })

-- typescript and javascript
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- disable tsserver formatting if you plan on formatting via null-ls
      client.resolved_capabilities.document_formatting = false
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }
})
nvim_lsp.tailwindcss.setup {}

local servers = {
  'html',
  'rust_analyzer',
  'bashls',
  'dockerls',
  'gdscript',
  'jsonls',
  'vimls',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

-- deno
-- require 'lspconfig'.denols.setup {
--   capabilities = capabilities,
--   on_attach = common_on_attach,
-- }

-- lua
require('lspconfig').sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.fn.sign_define('DiagnosticSignError', { text = '' })
vim.fn.sign_define('DiagnosticSignWarning', { text = '' })
vim.fn.sign_define('DiagnosticSignInformation', { text = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '' })

require('lspkind').init({})
require('trouble').setup({})
require('lsp.bindings')

