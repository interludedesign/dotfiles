return {
  {
    "williamboman/mason.nvim", -- Mason for managing LSP servers
    config = function()
      require("mason").setup()
    end,
  },
  {
    "saghen/blink.cmp", -- Completion engine
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- Setup global LSP capabilities with blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configure global LSP settings using the new vim.lsp.config API
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Ruby LSP specific configuration
      vim.lsp.config("ruby_lsp", {
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

      -- Enable common LSP servers directly
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ruby_lsp")
      vim.lsp.enable("ts_ls") -- TypeScript

      -- LSP keybindings - set globally since handlers changed in 0.11
      vim.api.nvim_create_autocmd("LspAttach", {
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
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
