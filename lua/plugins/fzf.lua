return {
    "ibhagwan/fzf-lua",
    keys = {
        {
            "<leader>8",
            "<cmd>FzfLua grep_cword<CR>",
            desc = "Grep Word Under Cursor",
        },
        {
            "<leader>vv",
            function()
                require("fzf-lua").live_grep({
                    cmd = "rg -t verilog --column --line-number --no-heading --color=always --smart-case --max-columns=4096",
                })
            end,
            desc = "Live Grep - Verilog",
        },
    },
    opts = {
        oldfiles = {
            -- In Telescope, <leader>fr would load old buffers.
            -- fzf lua does the same, but by default buffers visited in the current
            -- session are not included. This replicates that behaviour.
            include_current_session = true,
        },
        previewers = {
            builtin = {
                syntax_limit_b = 1024 * 100, -- 100KB
            },
        },
        grep = {
            -- One thing I missed from Telescope was the ability to live_grep and the
            -- run a filter on the filenames.
            -- Ex: Find all occurrences of "enable" but only in the "plugins" directory.
            -- With this change, I can sort of get the same behaviour in live_grep.
            -- ex: > enable --*/plugins/*
            -- I still find this a bit cumbersome. There's probably a better way of doing this.
            debug          = true,
--          glob_flag      = "--iglob", -- case insensitive globs
--          glob_separator = "%s%-%-",  -- query separator pattern (lua): ' --'

            rg_glob        = true,      -- enable glob parsing
            rg_glob_fn = function(query, opts)
                print "Hello"
                local regex, flags = query:match("^(.-)%s%-%-(.*)$")
                -- If no separator is detected will return the original query
                return (regex or query), flags
            end,
--          actions = {
--              ['ctrl-g'] = { require('fzf-lua.actions').toggle_ignore },
--          },
        },
    },
}
