local MAPPER = require 'utils'

MAPPER.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
MAPPER.nnoremap('gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
MAPPER.nnoremap('gr', '<cmd>lua vim.lsp.buf.rename()<CR>')
MAPPER.nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
MAPPER.nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
MAPPER.nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
MAPPER.nnoremap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
MAPPER.vnoremap('<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')

MAPPER.nnoremap('<leader>ll', '<cmd> :TroubleToggle<CR>')
MAPPER.nnoremap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
MAPPER.nnoremap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
MAPPER.nnoremap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
