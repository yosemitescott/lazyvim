if true then return {} end

-- NOTE: Specify the trigger character(s) used for luasnip
local trigger_text = ";"

return {
    "saghen/blink.cmp",
            -- !Important! Make sure you're using the latest release of LuaSnip
            -- `main` does not work at the moment
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
--  dependencies = 'rafamadriz/friendly-snippets',
--  version = 'v0.*',
    version = '*',

    opts = {
        keymap  = { preset = 'default' },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        enabled = function()
            local disabled_filetypes = { "neo-tree-popup" }
            return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype) and vim.b.completion ~= false
        end,
        snippets = {
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },
        sources = {
            default = { 'lsp', 'path', 'luasnip', 'buffer' },
            providers = {
                luasnip = {
                    name = "luasnip",
                    enabled = true,
                    module = "blink.cmp.sources.luasnip",
                    min_keyword_length = 2,
                    fallbacks = { "snippets" },
                    score_offset = 85,
                    max_items = 8,
                    -- Only show luasnip items if I type the trigger_text characters, so
                    -- to expand the "bash" snippet, if the trigger_text is ";" I have to
                    -- type ";bash"
                    should_show_items = function()
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                        -- NOTE: remember that `trigger_text` is modified at the top of the file
                        return before_cursor:match(trigger_text .. "%w*$") ~= nil
                    end,
                    -- After accepting the completion, delete the trigger_text characters
                    -- from the final inserted text
                    transform_items = function(ctx, items)
                        -- WARNING: Explicitly referencing ctx otherwise I was getting an "unused" warning
                        local _ = ctx
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                        local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
                        if trigger_pos then
                            for _, item in ipairs(items) do
                                item.textEdit = {
                                    newText = item.insertText or item.label,
                                    range = {
                                        start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
                                        ["end"] = { line = vim.fn.line(".") - 1, character = col },
                                    },
                                }
                            end
                        end
                        -- NOTE: After the transformation, I have to reload the luasnip source
                        -- Otherwise really crazy stuff happens and I spent way too much time
                        -- figurig this out
                        vim.schedule(function()
                            require("blink.cmp").reload("luasnip")
                        end)
                        return items
                    end,
                },
            },
        },
--      signature = { enabled = true },
    },
}

