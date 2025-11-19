-- Autocommands

-- Markdown line wrapping
vim.api.nvim_create_augroup('markdown_wrap', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'markdown_wrap',
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.keymap.set('n', 'j', 'gj', { buffer = true })
    vim.keymap.set('n', 'k', 'gk', { buffer = true })
  end,
})
