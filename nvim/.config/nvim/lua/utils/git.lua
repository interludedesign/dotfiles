local git = {}

function git.toggle_blame()
  if vim.bo.filetype == "fugitiveblame" then
    vim.api.nvim_buf_delete(0, {})
  else
    vim.api.nvim_command('Git blame')
  end
end

return git
