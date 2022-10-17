local MAPPER = {
  MODES = {
    NORMAL = 'n',
    VISUAL = 'v',
    INSERT = 'i'
  },
  map = function(type, input, output, options)
    options = options or {}
    vim.keymap.set(type, input, output, options)
  end
}

return MAPPER
