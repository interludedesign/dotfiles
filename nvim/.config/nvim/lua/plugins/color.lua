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
      hl.LineNrAbove = { fg = "#a9b1d6" }
      hl.LineNrBelow = { fg = "#a9b1d6" }
      hl.LineNr = { fg = "#a9b1d6" }
      hl.CursorLineNr = { fg = "#ff9e64", bold = true }
    end,
  },
}
