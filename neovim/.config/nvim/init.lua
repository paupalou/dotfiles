require('defaults')
require('utils')
require('folds')
require('theme')
require('bindings')
require('lsp')
require('plugins')

-- require each plugin config file
local conf_dir=os.getenv('XDG_CONFIG_HOME') or '~/.config'
local list_files_command="ls -pa -I init.lua " ..conf_dir.. "/nvim/lua/plugins | sed -n 's/.lua$//p'"
for dir in io.popen(list_files_command):lines() do require('plugins/'..dir) end
