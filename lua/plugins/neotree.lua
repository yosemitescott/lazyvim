return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            's1n7ax/nvim-window-picker',
            version = "v1.*",
            config = function()
                require'window-picker'.setup({
                    autoselect_one     = true,
                    include_current    = false,
                    other_win_hl_color = '#e35e4f',
                    filter_rules = {
                        -- filter using buffer options
                        bo = {
                            filetype = { 'neo-tree', "neo-tree-popup", "notify" },  -- if the file type is one of following, the window will be ignored
                            buftype  = { 'terminal', "quickfix" },                  -- if the buffer type is one of following, the window will be ignored
                        },
                    },
                })
            end,
        },

        opts = {
            window = {
                mappings = {
                    ["S"] = "split_with_window_picker",
                    ["s"] = "vsplit_with_window_picker",
                    ["v"] = "vsplit_with_window_picker",
                },
            },
        },
    },
}
