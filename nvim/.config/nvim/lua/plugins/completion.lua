return {
  "saghen/blink.cmp",

  version = "*",

  opts = {
    keymap = { preset = "default" },

    signature = { enabled = true },

    appearance = {
      nerd_font_variant = "normal",
    },

    completion = {
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", "label_description", gap = 4 },
            { "kind_icon", "kind" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
