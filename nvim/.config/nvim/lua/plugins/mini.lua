return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")

      statusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local filename      = statusline.section_filename({ trunc_width = 140 })
            local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
            local location      = statusline.section_location({ trunc_width = 75 })

            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local lsp_str = ""
            if #clients > 0 then
              local names = vim.tbl_map(function(c) return c.name end, clients)
              lsp_str = table.concat(names, " ")
            end

            return statusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = "MiniStatuslineDevinfo",  strings = { git, diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineDevinfo",  strings = { lsp_str } },
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
        },
      })
    end,
  },
}
