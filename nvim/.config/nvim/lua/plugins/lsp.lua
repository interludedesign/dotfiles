return {
  {
    "neovim/nvim-lspconfig", -- Core LSP support
    dependencies = {
      "williamboman/mason.nvim", -- Mason for managing LSP servers
      "williamboman/mason-lspconfig.nvim", -- Mason bridge for nvim-lspconfig
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Initialize Mason
      mason.setup()

      -- Basic `on_attach` function for LSP keybindings
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- Enhanced capabilities with blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Configure LSP floating windows with borders and padding
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- Automatically set up servers installed by Mason
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        -- Ruby LSP with YARD support
        ["ruby_lsp"] = function()
          lspconfig.ruby_lsp.setup({
            on_attach = on_attach,
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
        end,
      })

    end,
  },
}
