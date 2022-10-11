return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use('vim-ruby/vim-ruby')
  use('nvim-lua/popup.nvim')
  use('ThePrimeagen/harpoon')
  use('dense-analysis/ale')
  use('neovim/nvim-lspconfig')
  use('tpope/vim-commentary')
  use('jiangmiao/auto-pairs')
  use('tpope/vim-fugitive')
  use('preservim/nerdtree')
  use('thoughtbot/vim-rspec')
  use('vim-airline/vim-airline')
  use('mattn/emmet-vim')
  use('mustache/vim-mustache-handlebars')
  use('airblade/vim-gitgutter')
  use('sbdchd/neoformat')
  use('RRethy/nvim-treesitter-endwise')

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("nvim-treesitter/playground")
  -- use("romgrk/nvim-treesitter-context")
  use("RRethy/nvim-treesitter-textsubjects")

  -- Snippets
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip') -- Luasnip complection source for nvim-cmp

  -- Completion & Sources
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer') -- Completes words from current buffer
  use('hrsh7th/cmp-path') -- Completes paths
  use('hrsh7th/cmp-nvim-lua') -- Lua completion with special nvim context
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/cmp-nvim-lsp')

  -- Completion menu formatting with icon
  use('onsails/lspkind.nvim')

  -- Colorscheme section
  use("gruvbox-community/gruvbox")
  use("folke/tokyonight.nvim")

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- My plugins
  use("~/Code/nvim-plugins/azureutils.nvim")
  use("~/Code/nvim-plugins/luautils")

  -- Plenary
  use("nvim-lua/plenary.nvim")
end)
