return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()  -- Make sure Mason is properly initialized
    end,
  },

  -- Mason-lspconfig integration for auto-configuration of LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- Ensure mason-lspconfig is correctly initialized
      require("mason-lspconfig").setup({})

      -- LSP configuration via nvim-lspconfig
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- LSP server setup for different languages
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.ruby_ls.setup({
        capabilities = capabilities,
        init_options = {
          enabledFeatures = {
            documentSymbols = true,
            foldingRanges = true,
            selectionRanges = true,
            semanticHighlighting = true,
            formatting = true,
            codeActions = true,
          },
        },
      })

      -- Add OmniSharp configuration
      lspconfig.omnisharp.setup({
        cmd = { "dotnet", "/usr/local/bin/omnisharp/OmniSharp.dll" }, -- Make sure to point to your OmniSharp executable
        capabilities = capabilities,
        on_init = function(client)
          -- Additional initialization logic for OmniSharp if needed
        end,
      })

      -- LSP keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },

  -- Optional: Completion plugin (assuming blink.cmp for LSP completion)
  {
    "saghen/blink.cmp", -- Completion engine
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Ensure LSP capabilities are set for completion
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Update LSP configuration for completion integration
      vim.lsp.config('*', {
        capabilities = capabilities,
      })
    end,
  },
}
