-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local previewers = require("telescope.previewers")
-- local action_state = require("telescope.actions.state")
-- local conf = require("telescope.config").values
-- local actions = require("telescope.actions")

require("telescope").load_extension('harpoon')

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "Dotfiles",
    cwd = '~/.dotfiles'
  })
end

M.search_docs = function(live)
  live = live or false

  if live then
    require("telescope.builtin").live_grep({
      prompt_title = "Docs",
      cwd = '~/Docs'
    })
  else
    require("telescope.builtin").find_files({
      prompt_title = "Docs",
      cwd = '~/Docs'
    })
  end
end

return M
