if true then return {} end

return {
    "Vonr/align.nvim",
    keys = {
        {"<Leader>ea", function() require'align'.align_to_char(1, true, true)       end, mode = 'x', desc = "Aligns to 1 character, looking left"},
        {"<Leader>es", function() require'align'.align_to_char(2, true, true)       end, mode = 'x', desc = "Aligns to 2 characters, looking left and with previews"},
        {"<Leader>ew", function() require'align'.align_to_string(false, true, true) end, mode = 'x', desc = "Aligns to a string, looking left and with previews"},
        {"<Leader>er", function() require'align'.align_to_string(true, true, true)  end, mode = 'x', desc = "Aligns to a Lua pattern, looking left and with previews"},

    },


}



-- align_to_char(length, reverse, preview, marks)
-- align_to_string(is_pattern, reverse, preview, marks)
-- align(str, reverse, marks)
-- operator(fn, opts)
-- Where:
--      length: integer
--      reverse: boolean
--      preview: boolean
--      marks: table (e.g. {1, 0, 23, 15})
--      str: string (can be plaintext or Lua pattern if is_pattern is true)

-- Example gawip to align a paragraph to a string, looking left and with previews
-- vim.keymap.set(
--     'n',
--     'gaw',
--     function()
--         local a = require'align'
--         a.operator(
--             a.align_to_string,
--             { is_pattern = false, reverse = true, preview = true }
--         )
--     end,
--     NS
-- )
-- 
-- -- Example gaaip to aling a paragraph to 1 character, looking left
-- vim.keymap.set(
--     'n',
--     'gaa',
--     function()
--         local a = require'align'
--         a.operator(
--             a.align_to_char,
--             { length = 1, reverse = true }
--         )
--     end,
--     NS
-- )

