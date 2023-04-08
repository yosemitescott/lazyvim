return {
    "akinsho/toggleterm.nvim",
    keys = {
        { "<leader>t", "<cmd>ToggleTerm direction=float<cr>",      desc = "ToggleTerminal Float" },
        { "<leader>T", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerminal Horizontal" },
    },
    opts = {
        open_mapping = [[<c-\>]],
    },
}

-- Once initial terminal is open, <C-\> will toggle the terminal.  Then a new terminal can be populated by any number N:   N<C-\>

