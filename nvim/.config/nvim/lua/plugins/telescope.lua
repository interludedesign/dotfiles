return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "ThePrimeagen/harpoon",
    "benfowler/telescope-luasnip.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    -- Load Extensions
    telescope.load_extension("harpoon")
    telescope.load_extension("fzf")
    telescope.load_extension("luasnip")

    -- Setup Telescope
    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = { height = 0.95 },
        prompt_prefix = "🔍 ", -- Customize the prompt
      },
    })

    -- Custom Functions
    local M = {}

    M.search_dotfiles = function()
      builtin.find_files({
        prompt_title = "Dotfiles",
        cwd = vim.fn.expand("~/dotfiles"),
        hidden = true,
      })
    end

    M.git_changed_files = function()
      local git_root = vim.trim(vim.fn.system(
        "git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel 2>/dev/null"
      ))
      if vim.v.shell_error ~= 0 or git_root == "" then
        vim.notify("Not in a git repository", vim.log.levels.WARN)
        return
      end

      local function get_changed(branch)
        local result = vim.fn.systemlist(
          "git -C " .. vim.fn.shellescape(git_root) .. " diff --name-only " .. branch .. " 2>/dev/null"
        )
        return vim.v.shell_error == 0 and result or nil
      end

      local files = get_changed("main") or get_changed("origin/main") or {}
      files = vim.tbl_filter(function(f) return f ~= "" end, files)

      if #files == 0 then
        vim.notify("No files changed since main", vim.log.levels.INFO)
        return
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Changed since main",
        finder = require("telescope.finders").new_table({
          results = files,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry,
              ordinal = entry,
              path = git_root .. "/" .. entry,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = require("telescope.config").values.file_previewer({}),
      }):find()
    end

    M.pick_skill = function()
      local skills_dir = vim.fn.expand("~/dotfiles/work/code/skills")
      local handle = vim.uv.fs_scandir(skills_dir)
      if not handle then
        vim.notify("Skills directory not found: " .. skills_dir, vim.log.levels.WARN)
        return
      end

      local skills = {}
      while true do
        local name, type = vim.uv.fs_scandir_next(handle)
        if not name then break end
        if type == "directory" then
          table.insert(skills, name)
        end
      end
      table.sort(skills)

      require("telescope.pickers").new({}, {
        prompt_title = "Skills (Enter to open, Ctrl-i to insert, Ctrl-n to create)",
        finder = require("telescope.finders").new_table({
          results = skills,
          entry_maker = function(skill)
            local skill_path = vim.fn.expand("~/dotfiles/work/code/skills/") .. skill .. "/SKILL.md"
            return {
              value = skill,
              display = skill,
              ordinal = skill,
              path = skill_path,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = require("telescope.config").values.file_previewer({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          -- Enter: open the skill's SKILL.md for editing
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            if not entry then return end
            local skill_path = vim.fn.expand("~/dotfiles/work/code/skills/") .. entry.value .. "/SKILL.md"
            vim.cmd("edit " .. vim.fn.fnameescape(skill_path))
          end)

          -- Ctrl-i: insert skill name wrapped in backticks at cursor
          map("i", "<C-i>", function()
            actions.close(prompt_bufnr)
            local skill = action_state.get_selected_entry().value
            local pos = vim.api.nvim_win_get_cursor(0)
            local row, col = pos[1] - 1, pos[2]
            local text = "`" .. skill .. "`"
            vim.api.nvim_buf_set_text(0, row, col, row, col, { text })
            vim.api.nvim_win_set_cursor(0, { row + 1, col + #text })
          end)

          -- Ctrl-n: create a new skill using dot-skill-new and open its SKILL.md
          map("i", "<C-n>", function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local query = picker:_get_prompt()
            actions.close(prompt_bufnr)

            if not query or vim.trim(query) == "" then
              vim.notify("Please type a skill name first", vim.log.levels.WARN)
              return
            end

            local skill_name = vim.trim(query)
            local result = vim.fn.system("dot-skill-new " .. vim.fn.shellescape(skill_name))
            if vim.v.shell_error ~= 0 then
              vim.notify("dot-skill-new failed: " .. vim.trim(result), vim.log.levels.ERROR)
              return
            end

            local skill_path = vim.fn.expand("~/dotfiles/work/code/skills/") .. skill_name .. "/SKILL.md"
            vim.cmd("edit " .. vim.fn.fnameescape(skill_path))
            vim.notify("Created skill: " .. skill_name, vim.log.levels.INFO)
          end)

          return true
        end,
      }):find()
    end

    M.search_docs = function(live)
      live = live or false

      if live then
        builtin.live_grep({
          prompt_title = "Docs",
          cwd = vim.fn.expand("~/docs"),
          additional_args = { "--glob", "!**/4 - Archive/**" },
        })
      else
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local docs_util = require("utils.docs")
        
        local caller_win = vim.api.nvim_get_current_win()
        local caller_buf = vim.api.nvim_get_current_buf()

        builtin.find_files({
          prompt_title = "Docs (Ctrl-n to create new, Ctrl-i to insert link)",
          cwd = vim.fn.expand("~/docs"),
          find_command = { "fd", "--type", "f", "--exclude", "4 - Archive", "--strip-cwd-prefix", "-X", "ls", "-t" },
          attach_mappings = function(prompt_bufnr, map)
            -- Add custom keybinding to create new doc
            map("i", "<C-n>", function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local query = picker:_get_prompt()

              actions.close(prompt_bufnr)
              docs_util.create_doc(query)
            end)

            -- Ctrl-i: insert selected filename as a wiki link [[Name]] at cursor
            map("i", "<C-i>", function()
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if not entry then return end

              local filename = vim.fn.fnamemodify(entry.value, ":t:r")
              local link = "[[" .. filename .. "]]"

              local pos = vim.api.nvim_win_get_cursor(caller_win)
              local row, col = pos[1] - 1, pos[2]
              vim.api.nvim_buf_set_text(caller_buf, row, col, row, col, { link })
              vim.api.nvim_win_set_cursor(caller_win, { row + 1, col + #link })
            end)

            return true
          end,
        })
      end
    end

    M.search_meetings = function()
      local meetings_dir = vim.fn.expand("~/docs/work/2 - Areas/Meetings")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      builtin.find_files({
        prompt_title = "Meetings (Ctrl-n to create new)",
        cwd = meetings_dir,
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-X", "ls", "-t" },
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<C-n>", function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local query = picker:_get_prompt()

            actions.close(prompt_bufnr)

            if not query or vim.trim(query) == "" then
              vim.notify("Please type a meeting topic first", vim.log.levels.WARN)
              return
            end

            local topic = vim.trim(query)
            local result = vim.fn.system("dot-docs-create-meeting " .. vim.fn.shellescape(topic))
            if vim.v.shell_error ~= 0 then
              vim.notify("dot-docs-create-meeting failed: " .. vim.trim(result), vim.log.levels.ERROR)
              return
            end

            local date = os.date("%Y-%m-%d")
            local filename = "Meeting - " .. date .. " - " .. topic .. ".md"
            local filepath = meetings_dir .. "/" .. filename
            vim.cmd("edit " .. vim.fn.fnameescape(filepath))
            vim.notify("Created meeting: " .. filename, vim.log.levels.INFO)
          end)

          return true
        end,
      })
    end

    -- Keybindings

    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({
        additional_args = function()
          return { "--hidden" }
        end, -- Search hidden files
      })
    end, { noremap = true, desc = "Live Grep" })

    vim.keymap.set("n", "<leader>fj", builtin.grep_string, { noremap = true, desc = "Grep String" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { noremap = true, desc = "Resume Last Search" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, desc = "Find Files" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, desc = "List Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, desc = "Help Tags" })
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { noremap = true, desc = "Quickfix List" })
    vim.keymap.set("n", "<leader>fk", builtin.git_files, { noremap = true, desc = "Git Files" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { noremap = true, desc = "Commands" })
    vim.keymap.set("n", "<leader>fi", builtin.keymaps, { noremap = true, desc = "Keymaps" })
    vim.keymap.set("n", "<leader>gl", builtin.git_commits, { noremap = true, desc = "Git Commits" })
    vim.keymap.set("n", "<leader>fv", M.search_dotfiles, { noremap = true, desc = "Search Dotfiles" })
    vim.keymap.set("n", "<leader>fd", function()
      M.search_docs(false)
    end, { noremap = true, desc = "Search Docs" })
    vim.keymap.set("n", "<leader>fD", function()
      M.search_docs(true)
    end, { noremap = true, desc = "Live Search Docs" })
    vim.keymap.set("n", "<leader>fo", builtin.vim_options, { noremap = true, desc = "Vim Options" })
    vim.keymap.set("n", "<leader>fa", builtin.builtin, { noremap = true, desc = "Telescope Builtins" })
    vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { noremap = true, desc = "Spell Suggestions" })
    vim.keymap.set("n", "<leader>fl", function()
      telescope.extensions.luasnip.luasnip()
    end, { noremap = true, desc = "LuaSnip Suggestions" })
    vim.keymap.set("n", "<leader>fm", M.git_changed_files, { noremap = true, desc = "Files changed since main" })
    vim.keymap.set("n", "<leader>fp", M.pick_skill, { noremap = true, desc = "Pick Skill" })
    vim.keymap.set("n", "<leader>dm", M.search_meetings, { noremap = true, desc = "Search Meetings" })
  end,
}
