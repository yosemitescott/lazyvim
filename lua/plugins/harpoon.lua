return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>fa", ':lua require("harpoon.mark").add_file()<cr>',        desc = "Harpoon Add File" },
        { "<leader>fh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon Menu" },
        { "<leader>f1", ':lua require("harpoon.ui").nav_file(1)<cr>',         desc = "Harpoon File 1" },
        { "<leader>f2", ':lua require("harpoon.ui").nav_file(2)<cr>',         desc = "Harpoon File 2" },
        { "<leader>f3", ':lua require("harpoon.ui").nav_file(3)<cr>',         desc = "Harpoon File 3" },
        { "<leader>f4", ':lua require("harpoon.ui").nav_file(4)<cr>',         desc = "Harpoon File 4" },
    },
    opts = {
            menu = { width = vim.api.nvim_win_get_width(0) - 40},
    },
}




-- local M = {
--     "theprimeagen/harpoon",
--     event = "BufReadPost",
-- }
-- 
-- function M.opts()
--     local mark   = require("harpoon.mark")
--     local ui     = require("harpoon.ui")
--     local keymap = vim.api.nvim_set_keymap
-- 
--     keymap("n", "<leader>fa", ':lua require("harpoon.mark").add_file()<cr>',        {noremap = true, silent = true, desc = "Harpoon Add File"})
--     keymap("n", "<leader>fh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', {noremap = true, silent = true, desc = "Harpoon Menu"})
-- 
--     keymap("n", "<leader>f1", ':lua require("harpoon.ui").nav_file(1)<cr>', {noremap = true, silent = true, desc = "Harpoon File 1"})
--     keymap("n", "<leader>f2", ':lua require("harpoon.ui").nav_file(2)<cr>', {noremap = true, silent = true, desc = "Harpoon File 2"})
--     keymap("n", "<leader>f3", ':lua require("harpoon.ui").nav_file(3)<cr>', {noremap = true, silent = true, desc = "Harpoon File 3"})
--     keymap("n", "<leader>f4", ':lua require("harpoon.ui").nav_file(4)<cr>', {noremap = true, silent = true, desc = "Harpoon File 4"})
--     require("harpoon").setup({
--         menu = {
--             width = vim.api.nvim_win_get_width(0) - 40,
--         }
--     })
-- 
-- end
-- 
-- return M

