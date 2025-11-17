return {
  "saghen/blink.cmp",

  version = "*",

  completion = {
    menu = {
      -- Don't automatically show the completion menu
      auto_show = true,

      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 4 },
          { "kind_icon", "kind" },
        },
      },
    },
  },

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = "default" },

    signature = { enabled = true },

    appearance = {
      nerd_font_variant = "normal",
    },
  },
}
