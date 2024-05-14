return {
    "letieu/jot.lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {"<leader>fj",  function() require("jot").open() end, desc = "jot"},
    },
    opts = {
        win_opts = {
            relative = "editor",
            width = 100,
            height = 30,
            row = 5,
            col = 35,
        },
    },
}

