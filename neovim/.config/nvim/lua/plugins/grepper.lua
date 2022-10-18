local MAPPER = require('utils')
local greptools = {'rg', 'git', 'grep'}

vim.g.grepper = {
  tools = greptools,
  jump = 0,
  quickfix = 1,
  simple_prompt = 1
}

-- MAPPER.map(MAPPER.MODES.NORMAL, 'gs', '<plug>(GrepperOperator)', { silent = true, remap = true })
-- MAPPER.map('x', 'gs', '<plug>(GrepperOperator)', { silent = true })

-- MAPPER.map(MAPPER.MODES.NORMAL, '<leader>g', '<cmd> :Grepper<CR>')
-- MAPPER.map(MAPPER.MODES.NORMAL, '<leader>*', '<cmd> :Grepper -tool rg -cword -noprompt<CR>')
