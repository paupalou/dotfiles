-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require('packer').startup {
  function(use)
    -- packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    -- lua utils required for some plugins
    use 'nvim-lua/plenary.nvim'

    -- color scheme
    use 'mhartington/oceanic-next'
    use 'folke/tokyonight.nvim'

    -- fancy icons (font)
    use 'kyazdani42/nvim-web-devicons'

    -- statusline
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }

    -- tweak cursor hold performance
    use 'antoinemadec/FixCursorHold.nvim'

    -- commentarys
    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- must have tpope stuff
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    -- more objects targets
    use 'wellle/targets.vim'

    -- mru files and bookmarks on start
    use 'mhinz/vim-startify'

    -- visual signs for VCS
    use 'lewis6991/gitsigns.nvim'

    -- show marks on signcolumn
    use 'kshenoy/vim-signature'

    -- move between vim splits and tmux splits
    use 'christoomey/vim-tmux-navigator'

    -- remove delay on exit insert mode
    use 'jdhao/better-escape.vim'

    -- snippets like vscode
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- autocompletion engine
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'

    -- improved matchit
    use 'andymass/vim-matchup'

    --  lsp stuff
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'onsails/lspkind-nvim'
    use 'folke/lsp-trouble.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'j-hui/fidget.nvim'

    -- improve f/t/F/T
    use 'rhysd/clever-f.vim'

    -- buffer delete
    use 'famiu/bufdelete.nvim'

    -- buffer bar
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- minimap sidebar like vscode
    use {'wfxr/minimap.vim', run = ':!cargo install --locked code-minimap' }

    -- async search
    use 'mhinz/vim-grepper'

    -- fuzzyfinder
    use 'junegunn/fzf'
    use {
      'ibhagwan/fzf-lua',
      requires = {
        'vijaymarupudi/nvim-fzf',
        'kyazdani42/nvim-web-devicons' -- optional for icons
      }
    }

    -- fish shell scripts syntax
    use 'dag/vim-fish'

    -- treesitter syntax
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- typescript stuff
    -- use 'windwp/nvim-ts-autotag'
    use 'jose-elias-alvarez/typescript.nvim'

    -- file explorer
    use 'kyazdani42/nvim-tree.lua'

    -- show colors
    use 'norcalli/nvim-colorizer.lua'

    -- testing
    use 'liuchengxu/vista.vim'
    use 'folke/which-key.nvim'
    use 'TimUntersberger/neogit'
    use 'kevinhwang91/nvim-bqf'
    use 'gelguy/wilder.nvim'
    use 'olimorris/onedarkpro.nvim'
  end
}
