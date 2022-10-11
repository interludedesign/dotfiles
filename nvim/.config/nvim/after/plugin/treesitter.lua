require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "lua", "markdown", "json" },
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  endwise = {
    enable = true,
  },

  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      ['am'] = 'textsubjects-container-outer',
      ['im'] = 'textsubjects-container-inner',
    },
  },
}
