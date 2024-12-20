return {
  "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: Predefined snippets
    config = function()
        local ls = require("luasnip")

        -- Keymaps for LuaSnip
        vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, { silent = true })
        vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, { silent = true })
        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })

        -- Load VSCode-style snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- LuaSnip configuration
        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })
    end,
}
