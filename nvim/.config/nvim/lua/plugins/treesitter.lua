return {
  {
    "nvim-treesitter/nvim-treesitter", -- Core Treesitter plugin
    dependencies = {
      "RRethy/nvim-treesitter-endwise", -- Automatically adds `end` for Ruby, etc.
      "RRethy/nvim-treesitter-textsubjects", -- Adds text subject mappings
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false, -- Install parsers asynchronously

        highlight = {
          enable = true, -- Enable Treesitter-based syntax highlighting
        },

        endwise = {
          enable = false, -- Enable endwise plugin
        },

        textsubjects = {
          enable = true, -- Enable textsubjects plugin
          prev_selection = ",", -- Keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart", -- Select smart text objects
            ["am"] = "textsubjects-container-outer", -- Outer container
            ["im"] = "textsubjects-container-inner", -- Inner container
          },
        },
      })
    end,
  },
}
