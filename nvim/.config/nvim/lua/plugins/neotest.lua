return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-go", -- Go test adapter
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    -- Get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
          diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    -- Setup neotest with desired configuration
    require("neotest").setup({
      adapters = {
        require("neotest-go"), -- Add other adapters here if needed
      },
    })
  end,
}
