return {
    -- Git related plugins
    { "tpope/vim-rhubarb" },
    { "tpope/vim-fugitive",
        event = "BufEnter",
        keys = {
            { "<leader>gj", ":diffget //3<CR>",       desc = "Git diff left side" },
            { "<leader>gf", ":diffget //2<CR>",       desc = "Git diff right side" },
            { "<leader>gB", ":Git blame<CR>",         desc = "Git Blame via fugitive" },
            { "<leader>gC", ":Git commit<CR>",        desc = "Git Commit via fugitive" },
            { "<leader>gP", ":Git push<CR>",          desc = "Git push via fugitive" },
            { "<leader>gd", "<C-w>o:Gdiffsplit!<CR>", desc = "Git difftool via fugitive" },
            { "<leader>G",  ":G<CR>",                 desc = "Git fugitive" },
        },
    },
    { "lewis6991/gitsigns.nvim",
        keys = {
            { "<leader>gp", ":Gitsigns preview_hunk<CR>",              desc = "Gitsigns preview hunk in window" },
            { "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", desc = "Gitsigns Toggle Current Line Blame" },
        }
    },
}

-- GIT
--vim.keymap.set('n', '<leader>gc' , ':GCheckout<CR>',   { noremap = true, silent = true, desc = "Search/Replace Dialogue" })
--vim.keymap.set('n', '<leader>gs' , ':G<CR>')
