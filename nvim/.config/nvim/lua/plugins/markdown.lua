return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    -- Conceals `**bold**`/`*italic*`/backtick markers and draws real box-drawn tables;
    -- it manages conceallevel/concealcursor itself, nothing needed in set.lua for that.
    opts = {
      heading = {
        -- Leave `#`/`##` as-is rather than swapping it for an icon+background overlay -
        -- the raw syntax reads better than the glyph. Colour still comes from the
        -- @markup.heading.*.markdown highlights in plugins/color.lua.
        atx = false,
      },
      code = {
        -- "normal" skips the language banner/background block and just highlights
        -- the fence; "full" (default) is the heavier, busier style.
        style = "normal",
      },
      sign = {
        -- Gutter icons duplicate what's already rendered inline - skip them.
        enabled = false,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- tokyonight.nvim ships its own render-markdown integration (an orange accent
      -- reused for bullets/dashes/table borders) that reasserts itself after
      -- color.lua's on_highlights runs, so overriding these groups there gets
      -- clobbered. Setting them here, after setup(), makes this the last writer.
      local blue, muted, dim = "#82aaff", "#828bb8", "#737aa2"
      local groups = {
        RenderMarkdownBullet = { fg = dim },
        RenderMarkdownDash = { fg = dim },
        RenderMarkdownTableHead = { fg = muted, bold = true },
        RenderMarkdownTableRow = { fg = dim },
        RenderMarkdownCodeInline = { bg = "NONE", fg = "#4fd6be" },
        RenderMarkdownLink = { fg = blue },
        RenderMarkdownLinkTitle = { fg = blue, underline = true },
        RenderMarkdownWikiLink = { fg = blue },
      }
      for name, val in pairs(groups) do
        vim.api.nvim_set_hl(0, name, val)
      end
    end,
  },
}
