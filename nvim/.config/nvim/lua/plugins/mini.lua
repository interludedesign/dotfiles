return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })

      local minisnippets = require("mini.snippets")
      local gen_loader = require("mini.snippets").gen_loader
      minisnippets.setup({
        snippets = {
          gen_loader.from_file("~/.config/nvim/snippets/global.json"),
          gen_loader.from_lang(),
        },
      })
    end,
  },
}
