local gitsigns = require('gitsigns')
local MAPPER = require('utils')

gitsigns.setup({
  on_attach = function(bufnr)
    -- Navigation
    MAPPER.map(MAPPER.MODES.NORMAL, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gitsigns.next_hunk()
      end)
      return '<Ignore>'
    end, {
      expr = true,
    })

    MAPPER.map(MAPPER.MODES.NORMAL, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gitsigns.prev_hunk()
      end)
      return '<Ignore>'
    end, {
      expr = true,
    })

    -- Actions
    MAPPER.map(MAPPER.MODES.NORMAL, '<leader>hp', gitsigns.preview_hunk)
    MAPPER.map(MAPPER.MODES.NORMAL, '<leader>tb', gitsigns.toggle_current_line_blame)
    MAPPER.map(MAPPER.MODES.NORMAL, '<leader>hd', gitsigns.diffthis)
    MAPPER.map(MAPPER.MODES.NORMAL, '<leader>hD', function()
      gitsigns.diffthis('~')
    end)
  end,
})
