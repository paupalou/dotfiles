require('aerial').setup()

local MAPPER = require('utils')

MAPPER.map(MAPPER.MODES.NORMAL, ']a', '<cmd>:AerialToggle<CR>')
