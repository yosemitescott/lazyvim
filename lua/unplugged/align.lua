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

