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
    on_highlights = function(hl, colors)
      hl.LineNrAbove = { fg = "#a9b1d6" }
      hl.LineNrBelow = { fg = "#a9b1d6" }
      hl.LineNr = { fg = "#a9b1d6" }
      hl.CursorLineNr = { fg = "#ff9e64", bold = true }

      -- Markdown: calmer than the theme defaults, which give every heading level its
      -- own colour and reuse one loud orange for bullets/dashes/table borders. Bold
      -- hierarchy by weight/icon, not by a different hue per level.
      -- (The `RenderMarkdownH1Bg` etc. equivalents for render-markdown.nvim itself are
      -- set in plugins/markdown.lua, not here - render-markdown re-asserts its own
      -- colours after this callback runs, so setting them here is a no-op.)
      hl["@markup.heading.1.markdown"] = { fg = colors.blue, bold = true }
      hl["@markup.heading.2.markdown"] = { fg = colors.cyan, bold = true }
      hl["@markup.heading.3.markdown"] = { fg = colors.fg_dark, bold = true }
      hl["@markup.heading.4.markdown"] = { fg = colors.fg_dark, bold = true }
      hl["@markup.heading.5.markdown"] = { fg = colors.fg_dark, bold = true }
      hl["@markup.heading.6.markdown"] = { fg = colors.fg_dark, bold = true }

      -- Decorative glyphs (bullets, thematic-break dashes, table borders) - structure,
      -- not content, so they should recede rather than compete with the text.
      hl["@markup.list.markdown"] = { fg = colors.dark5 }
      hl["@punctuation.special.markdown"] = { fg = colors.comment }

      -- Inline code: a plain colour change reads fine without the boxed background.
      hl["@markup.raw.markdown_inline"] = { bg = colors.none, fg = colors.teal }

      -- Once render-markdown conceals the `**`/`*` markers, let bold/italic be actual
      -- weight changes rather than also recolouring the text.
      hl["@markup.strong.markdown_inline"] = { fg = colors.fg, bold = true }
      hl["@markup.italic.markdown_inline"] = { fg = colors.fg_dark, italic = true }
    end,
  },
}
