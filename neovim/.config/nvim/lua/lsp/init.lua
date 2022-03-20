local nvim_lsp = require('lspconfig')

local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

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

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('v', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  -- buf_set_keymap(
  --   'n',
  --   '<space>e',
  --   "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded' })<CR>",
  --   opts
  -- )
  -- buf_set_keymap(
  --   'n',
  --   '[d',
  --   "<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false, border = 'rounded' }})<CR>",
  --   opts
  -- )
  -- buf_set_keymap(
  --   'n',
  --   ']d',
  --   "<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false, border = 'rounded' }})<CR>",
  --   opts
  -- )
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
  vim.lsp.handlers.hoer,
  { border = 'rounded', max_width = 90, max_height = 70 }
)
vim.lsp.handlers['textDocument/definition'] = goto_definition('split')

local null_ls = require('null-ls')

local sources = {
  -- formatters
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.formatting.prettier,
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
nvim_lsp.tsserver.setup({
  capabilities = capabilities,

  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false

    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      eslint_bin = 'eslint_d',
      enable_formatting = true,
      formatter = 'eslint_d',
    })
    -- required to enable ESLint code actions and formatting
    ts_utils.setup_client(client)
  end,

  flags = {
    debounce_text_changes = 150,
  },
})

local servers = {
  'html',
  'rust_analyzer',
  'bashls',
  'dockerls',
  'gdscript',
  'jsonls',
  'graphql',
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
local sumneko_root_path = vim.fn.expand('$HOME/code/external/lua-language-server')
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

require('lspconfig').sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
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

