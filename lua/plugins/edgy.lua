if true then return {} end
return {
    "folke/edgy.nvim",
--  dependencies = {
--      'nvim-neo-tree/neo-tree.nvim',
--      optional = true,
--      config = function()
--          require('neo-tree').setup({
--              open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy' },
--          })
--      end,
--  },
    event = "VeryLazy",
    keys = {
        {
            "<leader>ue",
            function()
                require("edgy").toggle()
            end,
            desc = "Edgy Toggle",
        },
        -- stylua: ignore
        { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = {
        bottom = {
            {
                ft = "toggleterm",
                size = { height = 0.4 },
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
            {
                ft = "noice",
                size = { height = 0.4 },
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
            {
                ft = "lazyterm",
                title = "LazyTerm",
                size = { height = 0.4 },
                filter = function(buf)
                    return not vim.b[buf].lazyterm_cmd
                end,
            },
            "Trouble",
            { ft = "qf", title = "QuickFix" },
            {
                ft = "help",
                size = { height = 20 },
                -- don't open help files in edgy that we're editing
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            { ft = "spectre_panel", size = { height = 0.4 } },
        },
        left = {
            {
                title = "Neo-Tree",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                pinned = true,
                open = function()
                    vim.api.nvim_input("<esc><space>e")
                end,
                size = { height = 0.5 },
            },
            {
                title = "Neo-Tree Git",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                pinned = true,
                open = "Neotree position=right git_status",
            },
            {
                title = "Neo-Tree Buffers",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                pinned = true,
                open = "Neotree position=top buffers",
            },
--          {
--              ft = "Outline",
--              pinned = true,
--              open = "SymbolsOutline",
--          },
            "neo-tree",
        },
    },
}
