local MAPPER = require 'utils'

MAPPER.nmap('gs', '<plug>(GrepperOperator)', { silent = true })
MAPPER.xmap('gs', '<plug>(GrepperOperator)', { silent = true })

MAPPER.nnoremap('<leader>g', '<cmd> :Grepper<CR>')
MAPPER.nnoremap('<leader>*', '<cmd> :Grepper -tool rg -cword -noprompt<CR>')
