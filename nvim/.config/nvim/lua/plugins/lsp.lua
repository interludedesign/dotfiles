return {
  {
    "neovim/nvim-lspconfig", -- Core LSP support
    dependencies = {
      "williamboman/mason.nvim", -- Mason for managing LSP servers
      "williamboman/mason-lspconfig.nvim", -- Mason bridge for nvim-lspconfig
      "hrsh7th/nvim-cmp", -- Autocompletion plugin
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
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
      local cmp = require("cmp")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

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

      -- Automatically set up servers installed by Mason
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      })

      -- Set up `nvim-cmp` for autocompletion
      cmp.setup({
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
}
