return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use('vim-ruby/vim-ruby')
  use('nvim-lua/popup.nvim')
  use('ThePrimeagen/harpoon')
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
  use('github/copilot.vim')
  use { 'sthendev/mariana.vim', run='make' }

  -- Treesitter
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use("nvim-treesitter/playground")
  -- use("romgrk/nvim-treesitter-context")
  use("RRethy/nvim-treesitter-textsubjects")

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-cmdline'},
		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},

      -- Linting
      {'mfussenegger/nvim-lint'},

	  }
  }

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
  use("interludedesign/azureutils.nvim")
  use("interludedesign/luautils")

  -- Plenary
  use("nvim-lua/plenary.nvim")
end)
