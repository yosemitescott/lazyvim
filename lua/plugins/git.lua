return {
    -- Git related plugins
    { "tpope/vim-rhubarb" },
    { "tpope/vim-fugitive",
        event = "BufEnter",
        keys = {
            { "<leader>gj", ":diffget //3<CR>", desc = "Git diff left side" },
            { "<leader>gf", ":diffget //2<CR>", desc = "Git diff right side" },
            { "<leader>G", ":G<CR>", desc = "Git fugitive" },
        },
    },
}

-- GIT
--vim.keymap.set('n', '<leader>gc' , ':GCheckout<CR>',   { noremap = true, silent = true, desc = "Search/Replace Dialogue" })
--vim.keymap.set('n', '<leader>gs' , ':G<CR>')
