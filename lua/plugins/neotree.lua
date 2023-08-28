return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<leader>E", ':Neotree<cr>', desc = "Explorer Neotree (current file)" },
        },
        dependencies = {
            {
                's1n7ax/nvim-window-picker',
                name = 'window-picker',
                version = "2.*",
                config = function()
                    require 'window-picker'.setup(
                        {
                            hint = 'floating-big-letter',
                            autoselect_one     = true,
                            include_current    = false,
                            highlights = {
                                statusline = {
                                    focused = {
                                        fg = '#ededed',
                                        bg = '#4493c8',
                                        bold = true,
                                    },
                                    unfocused = {
                                        fg = '#ededed',
                                        bg = '#44cc41',
                                        bold = true,
                                    },
                                },
                            },
                            filter_rules = {
                                -- filter using buffer options
                                bo = {
                                    filetype = { 'neo-tree', "neo-tree-popup", "notify", "help", "fugitive" },  -- if the file type is one of following, the window will be ignored
                                    buftype  = { 'terminal', "quickfix" },                                      -- if the buffer type is one of following, the window will be ignored
                                },
--                          wo = {},        -- Window Options
--                          file_path_contains = {},        -- Window Options
                        },
                    }
                    )
                end,
            },
        },


        optional = true,
        opts = {
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },

            window = {
                position = "right",
                mappings = {
                    ["S"] = "split_with_window_picker",
                    ["s"] = "vsplit_with_window_picker",
                    ["v"] = "vsplit_with_window_picker",
                },
            },

            default_component_configs = {
                git_status = {
                    symbols = {
                        added     = " ",
                        modified  = " ",
                        removed   = " ",
                        ignored   = "",
                        conflict  = "󱃟",

--                      untracked = "";
--                      unstaged  = "";
--                      ignored   = "󰜺",
--                      ignored   = "",
--                      unstaged  = "󰊇";
--                      unstaged  = "󰰨",
--                      conflict  = "󱃞",
                    },
                },
            },
        },
    },
}

