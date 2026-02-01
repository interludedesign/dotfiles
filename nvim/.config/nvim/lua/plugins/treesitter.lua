return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      -- Setup with new syntax (optional, uses defaults if not called)
      require'nvim-treesitter'.setup {
        install_dir = vim.fn.stdpath('data') .. '/site'
      }

      -- Install parsers
      require'nvim-treesitter'.install {
        'markdown', 'markdown_inline', 'ruby', 'bash', 'lua', 'vim',
        'vimdoc', 'c_sharp', 'go', 'typescript', 'javascript', 'python',
        'json', 'css', 'sql', 'handlebars'
      }

      -- Map csharp alias to c_sharp parser
      vim.treesitter.language.register('c_sharp', 'csharp')

      -- Enable highlighting for all filetypes
      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Enable indent for all filetypes
      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
