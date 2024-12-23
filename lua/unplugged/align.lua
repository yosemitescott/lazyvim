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









-- Aligns text to a specified character or a default character
local function align_text(opts)
    -- Set default values
    local default_character = "<="
    local max_position      = 0
    local character         = opts.character or default_character
    local space             = opts.space or false
    local minimal_space     = opts.minimal_space or false
    local first_only        = (opts.first or false)

    -- Read the lines from the current buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

    -- Add space to the beginning of the character if requested
    if space then
        character = " " .. character
    end

    -- Escape any special characters
    local special_characters = { "%(", "%)", "%[", "%]", "%.", "%*" }
    for _, special_character in ipairs(special_characters) do
        if character == special_character then
            character = "%" .. character
            break
        end
    end

    -- Determine the position to align to
    for _, line in ipairs(lines) do
        if string.find(line, character) then
            if minimal_space then
                line = string.gsub(line, "%s+" .. character, " " .. character)
            end

            local current_position = string.find(line, character)
            max_position = math.max(max_position, current_position)

            if first_only then
                break
            end
        end
    end

    -- Perform the alignment
    for i, line in ipairs(lines) do
        if string.find(line, character) then
            local before, match, after = string.match(line, "^(.-)%s*(%" .. character .. ")(.*)$")
            if before and match and after then
                lines[i] = string.format("%-" .. max_position .. "s%s%s", before, match, after)
            end
        end
    end

    -- Set the updated lines to the current buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

