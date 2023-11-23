local neotree = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  init = function()
    vim.keymap.set("n", "<C-n>", "<cmd>:Neotree toggle<CR>", { desc = "Neotree toggle" })
    vim.keymap.set("n", "<leader>n", "<cmd>:Neotree reveal<CR>", { desc = "Neotree reveal" })

    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  end,
  opts = {
    close_if_last_window = true,
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added     = "",      -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "",      -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖",   -- this can only be used in the git_status source
          renamed   = "󰁕",  -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      }
    }
  }
}

local harpoon = {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function()
    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")
    vim.keymap.set("n", "<leader>`", function()
      harpoon_ui.toggle_quick_menu()
    end, { desc = "[H]arpoon quick menu" })
    vim.keymap.set("n", "<leader>m", function()
      harpoon_mark.add_file()
    end, { desc = "Harpoon [M]ark file" })
    vim.keymap.set("n", "<leader>1", function()
      harpoon_ui.nav_file(1)
    end, { desc = "Harpoon navigate file [1]" })
    vim.keymap.set("n", "<leader>2", function()
      harpoon_ui.nav_file(2)
    end, { desc = "Harpoon navigate file [2]" })
    vim.keymap.set("n", "<leader>3", function()
      harpoon_ui.nav_file(3)
    end, { desc = "Harpoon navigate file [3]" })
    vim.keymap.set("n", "<leader>4", function()
      harpoon_ui.nav_file(4)
    end, { desc = "Harpoon navigate file [4]" })
    vim.keymap.set("n", "<leader>5", function()
      harpoon_ui.nav_file(5)
    end, { desc = "Harpoon navigate file [5]" })
  end,
}

return {
  neotree,
  harpoon,
}
