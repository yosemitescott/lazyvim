return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "molecule-man/telescope-menufacture",
        --      "tsakirist/telescope-lazy.nvim",
        --      "telescope-file-browser.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
            --    require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("menufacture")
        end,
    },
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
        },
    },
    keys = {
        -- add a keymap to browse plugin files
        -- stylua: ignore
        {
            "<leader>fp",
            function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            desc = "Find Plugin File",
        },
        {
            "<leader>fg",
            "<cmd>Telescope live_grep<CR>",
            desc = "Live Grep",
        },
        {
            "<leader>gb",
            "<cmd>Telescope git_branches<CR>",
            desc = "Telescope Git Branches",
        },
        {
            "<leader>8",
            --    "<cmd>Telescope grep_string<CR>",
            "<cmd>lua require('telescope').extensions.menufacture.grep_string()<CR>",
            desc = "Grep Word Under Cursor - ctrl-6 to change",
        },
        --  {
        --    "<leader>fz",
        --    "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        --    desc = "Live Grep Args",
        --  },
        {
            "<leader>fx",
            "<cmd>lua require('telescope').extensions.menufacture.find_files()<CR>",
            desc = "Find Files - ctrl-6 to change",
        },
        {
            "<leader>fy",
            "<cmd>lua require('telescope').extensions.menufacture.git_files()<CR>",
            desc = "Git Files - ctrl-6 to change",
        },
        {
            "<leader>fz",
            "<cmd>lua require('telescope').extensions.menufacture.live_grep()<CR>",
            desc = "Live Grep - ctrl-6 to change",
        },
    },
}
