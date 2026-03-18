return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local merge_base = vim.fn.system("git merge-base HEAD main 2>/dev/null"):gsub("%s+", "")
      if merge_base ~= "" then
        gs.change_base(merge_base, true)
      end
    end,
  },
}
