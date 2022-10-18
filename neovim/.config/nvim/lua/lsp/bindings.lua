local MAPPER = require('utils')

MAPPER.map(MAPPER.MODES.NORMAL, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

MAPPER.map(MAPPER.MODES.NORMAL, '<leader>ll', '<cmd> :TroubleToggle<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
MAPPER.map(MAPPER.MODES.NORMAL, ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
