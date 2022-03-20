local MAPPER = {}
local function map(type, input, output, options)
  options = options or {}
  vim.api.nvim_set_keymap(type, input, output, options)
end

local function noremap(type, input, output)
  vim.api.nvim_set_keymap(type, input, output, { noremap = true, silent = true })
end

function MAPPER.imap(input, output, options)
  map('i', input, output, options)
end

function MAPPER.nmap(input, output, options)
  map('n', input, output, options)
end

function MAPPER.xmap(input, output, options)
  map('x', input, output, options)
end

function MAPPER.nnoremap(input, output)
  noremap('n', input, output)
end

function MAPPER.inoremap(input, output)
  noremap('i', input, output)
end

function MAPPER.vnoremap(input, output)
  noremap('v', input, output)
end

return MAPPER
