local M = {}

-- ----------------------------------------------------------------------------------------------
-- Function to manage my comment banners
-- ----------------------------------------------------------------------------------------------
-- Table of banners
local banners = {
    [0] = "---------------------------------------",
    [1] = "--------------------------------------------------------------------",
    [2] = "--------------------------------------------------------------------------------------------------------------------",
    [3] = "=================================================================================",
    [4] = "==========================================================================================================="
}

local function get_comment_string()
    local ft = vim.bo.filetype
    if ft == 'verilog_systemverilog' then
        return '//'
    elseif ft == 'lua' then
        return '--'
    else
        return '#'
    end
end

-- Function to expand cb# abbreviation
local function expand_cb(num)
    local comment_str = get_comment_string()
    local banner = banners[num] or banners[0]  -- Default to cb0 if invalid number

    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]

    local before = line:sub(1, col - 2)  -- Exclude 'cb'
    local after = line:sub(col + 1)
    local new_col

    -- Check if the line is already a comment
    if before:match("^%s*" .. vim.pesc(comment_str)) then
        vim.api.nvim_set_current_line(before .. banner .. after)
        new_col = #before + 1 + #banner
    else
        vim.api.nvim_set_current_line(before .. comment_str .. " " .. banner .. after)
        new_col = #before + #comment_str + 1 + #banner
    end

    -- Move cursor to the end of the inserted banner
    vim.api.nvim_win_set_cursor(0, {row, new_col})
end


-- Set up autocmd to trigger expansion
function M.setup_cb_expansion()
    vim.api.nvim_create_autocmd("InsertCharPre", {
        pattern = "*",
        callback = function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if line:sub(col - 1, col) == "cb" and vim.v.char:match("%d") then
                local num = tonumber(vim.v.char)
                vim.schedule(function()
                    expand_cb(num)
                end)
                vim.v.char = ""
            end
        end
    })
end



-- ----------------------------------------------------------------------------------------------
-- Function to return the method name of a SystemVerilog task or function
-- ----------------------------------------------------------------------------------------------
M.get_current_method_name = function()
    local current_line = vim.fn.line('.')

    for i = current_line, 1, -1 do
        local line = vim.fn.getline(i)

        -- Match class-style function/task definitions (e.g., function void class_name::method_name)
        local class_name, method_name = line:match("^%s*function%s+[%w%s:]+%s+([%w_]+)::([%w_]+)")
        if class_name and method_name then
            return method_name
        end

        -- Match class-style function/task definitions (e.g., function void class_name::method_name)
        class_name, method_name = line:match("^%s*task%s+([%w_]+)::([%w_]+)")
        if class_name and method_name then
            return method_name
        end

        -- Match regular function definitions (e.g., function void method_name)
        method_name = line:match("^%s*function%s+[%w%s:]+%s+([%w_]+)")
        if method_name then
            return method_name
        end

        -- Match task definitions (e.g., task method_name)
        method_name = line:match("^%s*task%s+([%w_]+)")
        if method_name then
            return method_name
        end

        -- Stop searching if we find the end of the previous function/task but allow starting at the end of the task/function
        if i ~= current_line and ( line:match("^%s*end%s*function") or line:match("^%s*end%s*task") )then
            break
        end
    end

    return '"Method Name Not Found"'
end

-- ==============================================================================================
--
--                      The rest of the functions are for use with CodeCompanion
--
-- ==============================================================================================

-- ----------------------------------------------------------------------------------------------
-- Creates a temporary Markdown file with the given content and prefix
-- ----------------------------------------------------------------------------------------------
local function create_temp_file(content, prefix)
    local temp_file = vim.fn.tempname() .. "_" .. prefix .. ".md"
    local file = io.open(temp_file, "w")
    if file then
        file:write(content)
        file:write("\n\nTemporary file: " .. temp_file)  -- Add this line
        file:write("\n\nSuggested prompts:")
        file:write("\nI've just shared my LuaSnip configuration and snippets. Can you help me optimize my LuaSnip setup or suggest improvements for my snippets?")
        file:write("\nI've just shared my Neovim configuration. Can you help me understand how my plugin management is set up and suggest any improvements?\n")
        file:close()
        return temp_file
    else
        print("Error: Could not create temporary file")
        return nil
    end
end

-- ----------------------------------------------------------------------------------------------
-- Gathers Neovim configuration and saves it to a temporary file
-- ----------------------------------------------------------------------------------------------
function M.share_config()
    local config_files = {
        vim.fn.stdpath("config") .. "/init.lua",
        vim.fn.stdpath("config") .. "/lua/config/lazy.lua",
        vim.fn.stdpath("config") .. "/lua/config/options.lua",
        vim.fn.stdpath("config") .. "/lua/config/keymaps.lua",
        vim.fn.stdpath("config") .. "/lua/config/utils.lua",
    }

    local plugin_config_dir = vim.fn.stdpath("config") .. "/lua/plugins"

    local output = "Neovim Configuration:\n\n"

    local function add_file_content(file)
        if vim.fn.filereadable(file) == 1 then
            local content = table.concat(vim.fn.readfile(file), "\n")
            if not content:match("^%s*if%s+true%s+then%s+return%s+{}%s+end") then
                output = output .. "File: " .. file .. "\n```lua\n" .. content .. "\n```\n\n"
            end
        end
    end

    for _, file in ipairs(config_files) do
        add_file_content(file)
    end

    if vim.fn.isdirectory(plugin_config_dir) == 1 then
        output = output .. "Plugin Configurations:\n\n"
        local plugin_files = vim.fn.glob(plugin_config_dir .. "/*.lua", false, true)
        for _, file in ipairs(plugin_files) do
            add_file_content(file)
        end
    end

    local temp_file = create_temp_file(output, "nvim_config")
    if temp_file then
        vim.cmd("edit " .. temp_file)
        print("Configuration saved to " .. temp_file .. ". Use ShareWithCodeCompanion to share this file.")
    end
end

-- ----------------------------------------------------------------------------------------------
-- Gathers LuaSnip configuration and snippets, saving them to a temporary file
-- ----------------------------------------------------------------------------------------------
function M.share_snippets()
    local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
    local luasnip_config = vim.fn.stdpath("config") .. "/lua/plugins/luasnip.lua"
    local output = "LuaSnip Configuration and Snippets:\n\n"

    local function add_file_content(file, is_config)
        if vim.fn.filereadable(file) == 1 then
            local content = table.concat(vim.fn.readfile(file), "\n")
            local filename = vim.fn.fnamemodify(file, ":t")
            if is_config then
                output = output .. "LuaSnip Configuration:\n"
            else
                local filetype = vim.fn.fnamemodify(filename, ":r")
                output = output .. "Filetype: " .. filetype .. "\n"
            end
            output = output .. "File: " .. file .. "\n```lua\n" .. content .. "\n```\n\n"
        end
    end

    add_file_content(luasnip_config, true)

    if vim.fn.isdirectory(snippets_dir) == 1 then
        local snippet_files = vim.fn.glob(snippets_dir .. "/*.lua", false, true)
        for _, file in ipairs(snippet_files) do
            add_file_content(file, false)
        end
    else
        output = output .. "Snippets directory not found: " .. snippets_dir .. "\n"
    end

    local temp_file = create_temp_file(output, "nvim_snippets")
    if temp_file then
        vim.cmd("edit " .. temp_file)
        print("Snippets saved to " .. temp_file .. ". Use ShareWithCodeCompanion to share this file.")
        print("I've just shared my LuaSnip configuration and snippets. Can you help me optimize my LuaSnip setup or suggest improvements for my snippets?")
    end
end

-- ----------------------------------------------------------------------------------------------
-- Shares the current buffer with CodeCompanion if it's a temporary file created by this module
-- ----------------------------------------------------------------------------------------------
function M.share_temp_file()
    local current_file = vim.fn.expand("%:p")
    if current_file:match("_nvim_%w+%.md$") then
        vim.fn.setreg("+", current_file)
        print("File path copied to clipboard: " .. current_file)
        print("Please use the /buffer command in CodeCompanion chat and paste this path.")
    else
        print("Error: Current buffer is not a CodeCompanion temporary file.")
    end
end

-- ----------------------------------------------------------------------------------------------
-- Copies the time into the system clipboard
-- ----------------------------------------------------------------------------------------------
function M.copy_uvm_error_time()
  -- Get the current line
  local line = vim.api.nvim_get_current_line()

  -- Find the time using pattern matching
  local time = line:match("@ ([%d%.]+ ns):")

  if time then
    -- Copy the time to the system clipboard
    vim.fn.setreg('+', time)
    print("Copied time: " .. time)
  else
    print("No time found in the current line")
  end
end

-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

return M

