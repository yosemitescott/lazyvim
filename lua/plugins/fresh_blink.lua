return {
    "saghen/blink.cmp",
    opts = {
        keymap  = {
            preset = 'default',
            ['<CR>'] = {},          -- return acts normal inside of selecting a completion
        },
        sources = {
            providers = {
                buffer = { min_keyword_length = 3, },
                path   = { enabled = false, },
                }
        },
    },
}
