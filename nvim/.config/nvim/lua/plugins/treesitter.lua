return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { 
        "markdown", "markdown_inline", "ruby", "bash", "lua", "vim", 
        "vimdoc", "c_sharp", "go", "typescript", "javascript", "python", 
        "json", "css", "sql" 
      },
      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },

      indent = {
        enable = true,
      },

      endwise = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      
      -- Map csharp alias to c_sharp parser
      vim.treesitter.language.register("c_sharp", "csharp")
    end,
  },
}
