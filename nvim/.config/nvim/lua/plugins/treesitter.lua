return {
  {
    "nvim-treesitter/nvim-treesitter", -- Core Treesitter plugin
    dependencies = {
      "RRethy/nvim-treesitter-endwise", -- Automatically adds `end` for Ruby, etc.
      "RRethy/nvim-treesitter-textsubjects", -- Adds text subject mappings
    },
    build = ":TSUpdate", -- Automatically updates installed parsers
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "ruby", "lua", "markdown", "json", "go" }, -- Add languages as needed
        sync_install = false, -- Install parsers asynchronously

        highlight = {
          enable = true, -- Enable Treesitter-based syntax highlighting
          additional_vim_regex_highlighting = false,
        },

        endwise = {
          enable = true, -- Enable endwise plugin
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
