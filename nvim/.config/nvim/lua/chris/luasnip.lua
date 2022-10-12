local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })

ls.add_snippets("all", {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  })
})

ls.config.set_config {
  history = false,

  updateevents = "TextChanged,TextchangedI",

  enable_autosnippets = false,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<–", "Error" } },
      },
    },
  },
}

-- Expand snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Jump back snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("n", "<leader><leader>fs", "<cmd>source ~/.config/nvim/lua/chris/luasnip.lua<CR>")

ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "-- this is what was expanded!"),
  },
}
