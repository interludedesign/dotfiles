return {
  {
    "nvim-treesitter/nvim-treesitter", -- Core Treesitter plugin
    dependencies = {
      "RRethy/nvim-treesitter-endwise", -- Automatically adds `end` for Ruby, etc.
      "RRethy/nvim-treesitter-textsubjects", -- Adds text subject mappings
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "markdown_inline", "ruby", "bash", "lua", "vim", "vimdoc", "c_sharp", "go", "typescript", "javascript" }, -- Ensure parsers are installed
        sync_install = false, -- Install parsers asynchronously

        highlight = {
          enable = true, -- Enable Treesitter-based syntax highlighting
          additional_vim_regex_highlighting = { "markdown" }, -- Ensure markdown highlights work
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
