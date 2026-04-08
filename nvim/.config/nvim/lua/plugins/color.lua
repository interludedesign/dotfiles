return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, _)
      hl.LineNr = { fg = "#7e8abd" }
      hl.CursorLineNr = { fg = "#ff9e64", bold = true }
    end,
  },
}
