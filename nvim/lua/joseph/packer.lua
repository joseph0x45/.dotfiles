vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use "theprimeagen/harpoon"
  use "m4xshen/autoclose.nvim"
  use "neovim/nvim-lspconfig"
  use({
    "L3MON4D3/LuaSnip",
    tag = "v2.*",
  })
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP completion source
      "hrsh7th/cmp-buffer",      -- Buffer completions
      "hrsh7th/cmp-path",        -- Path completions
      "hrsh7th/cmp-cmdline",     -- Command-line completions
      "saadparwaiz1/cmp_luasnip" -- Snippet completions
    },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,}
    use "terrortylor/nvim-comment"
    use "lukas-reineke/indent-blankline.nvim"
    use "joseph0x45/md_todo"
    use "joseph0x45/arduinoo"
    use "AbdelrahmanDwedar/awesome-nvim-colorschemes"
 end)
