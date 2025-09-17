return {
    "folke/noice.nvim",
     opts = {
         presets = {
             bottom_search = false, -- use a classic bottom cmdline for search
         },
     },

--   opts = function(_, opts)
--     opts.routes = vim.list_extend(opts.routes or {}, {
--       {
--         filter = {
--           event = "msg_show",
--           kind = "search_count",
--           find = "^%d+ matches?",  -- This pattern matches the output of :g/
--         },
--         view = "popup",
--         opts = {
--           size = { width = "80%", height = "80%" },
--           position = "10%",
--           border = {
--             style = "rounded",
--             padding = { 0, 1 },
--           },
--           win_options = {
--             winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
--           },
--         },
--       },
--     })
-- 
--     -- Ensure messages don't disappear quickly
--     opts.messages = vim.tbl_deep_extend("force", opts.messages or {}, {
--       view_search = false,  -- Disable default search count view
--     })
-- 
--     opts.views = vim.tbl_deep_extend("force", opts.views or {}, {
--       popup = {
--         border = {
--           style = "rounded",
--           padding = { 0, 1 },
--         },
--         win_options = {
--           winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
--         },
--       },
--     })
-- 
--     -- Disable auto-closing of messages
--     opts.popupmenu = vim.tbl_deep_extend("force", opts.popupmenu or {}, {
--       backend = "nui",
--     })
-- 
--     return opts
--   end,
}
