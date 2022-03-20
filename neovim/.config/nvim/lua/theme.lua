vim.cmd [[ syntax on ]]
vim.cmd [[ colorscheme OceanicNext ]]

vim.o.termguicolors = true
vim.o.background = 'dark'

local M = {
  base00 = '#1b2b34',
  base01 = '#343d46',
  base02 = '#4f5b66',
  base03 = '#65737e',
  base04 = '#a7adba',
  base05 = '#c0c5ce',
  base06 = '#cdd3de',
  base07 = '#d8dee9',
  red = '#ec5f67',
  orange = '#f99157',
  yellow = '#fac863',
  green = '#99c794',
  cyan = '#62b3b2',
  blue = '#6699cc',
  purple = '#c594c5',
  brown = '#ab7967',
  white = '#ffffff',
}

-- comments in italic
vim.cmd [[ hi Comment gui=italic ]]
-- sign colors
vim.cmd [[ hi SignatureMarkText guifg=#0083ba ]]

-- lsp colors
vim.cmd [[ hi LspSignatureSearch guifg=#c594c5 gui=bold ]]

vim.cmd [[ hi DiagnosticError guifg=#F45D4C ]]
vim.cmd [[ hi DiagnosticUnderlineError guifg=#F45D4C gui=undercurl ]]

vim.cmd [[ hi DiagnosticWarn guifg=#F7A541 ]]
vim.cmd [[ hi DiagnosticUnderlineWarn guifg=#F7A541 gui=undercurl ]]

vim.cmd [[ hi DiagnosticInfo guifg=#A1DBB2 ]]
vim.cmd [[ hi DiagnosticUnderlinefInfo guifg=#A1DBB2 gui=undercurl ]]

vim.cmd [[ hi DiagnosticHint guifg=#FEE5AD ]]
vim.cmd [[ hi DiagnosticUnderlineHint guifg=#FEE5AD gui=undercurl ]]

vim.cmd [[ hi NormalFloat guibg=#1b2b34 ]]
vim.cmd [[ hi Pmenu guibg=#1F323C ]]
vim.cmd [[ hi PmenuSel guibg=#2A4250 ]]
vim.cmd [[ hi FloatBorder guifg=#f99157 ]]

vim.cmd [[ hi link CmpDocumentation NormalFloat ]]
vim.cmd [[ hi link CmpDocumentationBorder FloatBorder ]]

return M
