return {
    "L3MON4D3/LuaSnip",
    event = "BufReadPost",
    build = "make install_jsregexp",
    opts = {
        -- This tells LuaSnip to remember to keep around the last snippet.
        -- You can jump back into it even if you move outside of the selection
        history = false,

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",

        -- Autosnippets:
        enable_autosnippets = true,
        store_selection_keys = "<A-p>",
        -- ext_opts = {
        --   [require("luasnip.util.types").choiceNode] = {
        --     active = {
        --       virt_text = { { "*", "GruvboxOrange" } },
        --     },
        --   },
        -- },
    },
    opts = function(_, opts)
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
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
