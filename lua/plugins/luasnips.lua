-- if true then return {} end
-- return {
--     'saghen/blink.cmp',
--     version = '*',
--     -- !Important! Make sure you're using the latest release of LuaSnip
--     -- `main` does not work at the moment
--     dependencies = {
--         'L3MON4D3/LuaSnip',
--         version = 'v2.*',
--         build = "make install_jsregexp",
--         opts = function(_, opts)
--             require("luasnip/loaders.from_vscode").lazy_load()
--             require("luasnip.loaders.from_lua").load({ paths = {"$MY_SHARED/lazyvim/nvim/lua/snippets"} })
--         end,
--     },
--     opts = {
--         snippets = {
--             expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
--             active = function(filter)
--                 if filter and filter.direction then
--                     return require('luasnip').jumpable(filter.direction)
--                 end
--                 return require('luasnip').in_snippet()
--             end,
--             jump = function(direction) require('luasnip').jump(direction) end,
--         },
--         sources = {
--             default = { 'lsp', 'path', 'luasnip', 'buffer' },
--         },
--     },
-- }

return {
    "L3MON4D3/LuaSnip",
--    version = "v2.*",
----  event = "BufReadPost",
--    build = "make install_jsregexp",
    opts = function(_, opts)
        -- This tells LuaSnip to remember to keep around the last snippet if true
        -- You can jump back into it even if you move outside of the selection
        opts.history = true

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        opts.updateevents = "TextChanged,TextChangedI"

        -- Autosnippets:
        opts.enable_autosnippets = true
        opts.store_selection_keys = "<A-p>"

        opts.ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "*", "GruvboxOrange" } },
            },
          },
        }

        require("luasnip.loaders.from_lua").load({ paths = {vim.env.XDG_CONFIG_HOME .. "/nvim/lua/snippets"} })
        require("luasnip/loaders/from_vscode").lazy_load()

        local ls = require("luasnip")

        -- this now matches hjkl movements - h goes back, l goes forward, j selects the next choice, k selects the previous choice

        -- <c-l> is my expansion key  - this will expand the current item or jump to the next item within the snippet.
        vim.keymap.set({ "i", "s" }, "<c-l>", function()
            if ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- <c-h> is my jump backwards key. - this always moves to the previous item within the snippet
        vim.keymap.set({ "i", "s" }, "<c-h>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        -- <c-l> is selecting within a list of options.
        -- This is useful for choice nodes (introduced in the forthcoming episode 2)
        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.choice_active() then
                ls.change_choice(-1)
            end
        end)

        vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

        -- shorcut to source my luasnips file again, which will reload my snippets
        --vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

        --  vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
        vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
    end,

    --keys = function()
    --  return {}
    --end,
}
