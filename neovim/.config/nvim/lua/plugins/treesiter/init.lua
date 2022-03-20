local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  ensure_installed = { 'typescript', 'html', 'tsx', 'lua', 'json', 'rust', 'css', 'javascript' },
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
  autotag = { enable = true },
})
