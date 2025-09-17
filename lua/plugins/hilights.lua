local M = {
    't9md/vim-quickhl',                     -- Quick Highlighting
    keys = {
        {"<leader>m", "<Plug>(quickhl-manual-this)",  desc = "Mark",        mode = {"n", "v"}},
        {"<leader>M", "<Plug>(quickhl-manual-reset)", desc = "Reset Marks", mode = {"n", "v"}},
    }
--  'dvoytik/hi-my-words.nvim',
--  config = function(_, opts) require("hi-my-words").setup(opts) end,
--  keys = {
--      {"<leader>m", ":HiMyWordsToggle<CR>",  desc = "Mark",        mode = {"n", "v"}},
--      {"<leader>M", ":HiMyWordsClear<CR>)",  desc = "Reset Marks", mode = {"n", "v"}},
--  },
--  'dwrdx/mywords.nvim',
--  keys = {
--      {"<leader>m", ":lua require'mywords'.hl_toggle()<CR>",  desc = "Mark",        mode = {"n", "v"}},
--      {"<leader>M", ":lua require'mywords'.uhl_all()<CR>)",  desc = "Reset Marks", mode = {"n", "v"}},
--  },
}

-- --  keymap('n', '<leader>w' , '<Plug>(quickhl-manual-this-whole-word)', {noremap = true, silent = true, desc = "Mark Whole Work"})
--
-- -- nmap <Space>c <Plug>(quickhl-manual-clear)
-- -- vmap <Space>c <Plug>(quickhl-manual-clear)
-- -- nmap <Space>M <Plug>(quickhl-manual-reset)
-- -- xmap <Space>M <Plug>(quickhl-manual-reset)
-- -- nmap <Space>j <Plug>(quickhl-cword-toggle)
-- -- nmap <Space>] <Plug>(quickhl-tag-toggle)
-- -- map H <Plug>(operator-quickhl-manual-this-motion)
-- end

return M


