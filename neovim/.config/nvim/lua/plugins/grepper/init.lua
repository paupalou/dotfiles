require 'plugins/grepper/bindings'

local greptools = {'rg', 'git', 'grep'}

vim.g.grepper = {
  tools = greptools,
  jump = 0,
  quickfix = 1,
  simple_prompt = 1
}
