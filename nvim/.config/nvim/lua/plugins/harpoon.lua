return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('harpoon').setup({
      menu = {
        width = 80,
        height = 12,
      }
    })

    local map = vim.keymap.set

    -- Harpoon Keymaps
    map("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>zz", { noremap = true, silent = true })
    map("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>zz", { noremap = true, silent = true })
    map("n", "<leader>j", ":lua require('harpoon.ui').nav_file(1)<CR>zz", { noremap = true, silent = true })
    map("n", "<leader>k", ":lua require('harpoon.ui').nav_file(2)<CR>zz", { noremap = true, silent = true })
    map("n", "<leader>l", ":lua require('harpoon.ui').nav_file(3)<CR>zz", { noremap = true, silent = true })
    map("n", "<leader>;", ":lua require('harpoon.ui').nav_file(4)<CR>zz", { noremap = true, silent = true })
  end,
}
