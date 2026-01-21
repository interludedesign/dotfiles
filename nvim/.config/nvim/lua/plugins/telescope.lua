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

    M.search_docs = function(live)
      live = live or false

      if live then
        builtin.live_grep({
          prompt_title = "Docs",
          cwd = vim.fn.expand("~/docs"),
        })
      else
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local docs_util = require("utils.docs")
        
        builtin.find_files({
          prompt_title = "Docs (Ctrl-n to create new)",
          cwd = vim.fn.expand("~/docs"),
          attach_mappings = function(prompt_bufnr, map)
            -- Add custom keybinding to create new doc
            map("i", "<C-n>", function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local query = picker:_get_prompt()
              
              actions.close(prompt_bufnr)
              docs_util.create_doc(query)
            end)
            
            return true
          end,
        })
      end
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
  end,
}
