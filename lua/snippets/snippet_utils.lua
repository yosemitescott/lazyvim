local ls = require("luasnip")
local M = {}

-- Export LuaSnip functions
M.s    = ls.snippet
M.t    = ls.text_node
M.i    = ls.insert_node
M.f    = ls.function_node
M.d    = ls.dynamic_node
M.c    = ls.choice_node
M.sn   = ls.snippet_node
M.fmt  = require("luasnip.extras.fmt").fmt
M.fmta = require("luasnip.extras.fmt").fmta
M.rep  = require("luasnip.extras").rep
M.l    = require("luasnip.extras").lambda

-- Initialize snippet tables
M.snippets = {}
M.autosnippets = {}

-- Common function to create snippets
M.cs = function(trigger, nodes, opts)
    opts = opts or {}
    local snippet = M.s(trigger, nodes)
    local target_table = opts.autosnippet and M.autosnippets or M.snippets

    if opts.key then
        local pattern = opts.pattern or "*"
        vim.api.nvim_create_autocmd("InsertEnter", {
            pattern = pattern,
            callback = function()
                vim.keymap.set("i", opts.key, function()
                    ls.snip_expand(snippet)
                end, { noremap = true, silent = true, buffer = true })
            end,
        })
    end

    table.insert(target_table, snippet)
end

-- Function to get current filename
M.get_filename = function()
    return vim.fn.expand("%:t:r")
end

-- Function to create a comment header
M.create_comment_header = function(text)
    return M.t({
        "//------------------------------------------------------------------------------",
        "// " .. text,
        "//------------------------------------------------------------------------------",
    })
end

return M







--   I've just shared my LuaSnip configuration and snippets. Can you help me optimize my LuaSnip setup or suggest improvements for my snippets?
--   
--   ## CodeCompanion (OpenAI)
--   
--   Certainly! I've reviewed your LuaSnip configuration and snippets. Here are some observations and suggestions for optimization and improvement:
--   
--   1. Consistent formatting:
--      Your snippets are well-structured, but there's some inconsistency in formatting across files. Consider using a Lua formatter to maintain consistency.
--   
--   2. Reusable functions:
--      The `cs` function is repeated in multiple files. Consider creating a shared utility file for common functions like this.
--   
--   3. Dynamic snippet generation:
--      You're already using dynamic nodes in some snippets. Consider extending this approach to create more flexible snippets, especially for repetitive patterns.
--   
--   4. Snippet organization:
--      Group related snippets together and add comments to separate different categories. This will make maintenance easier.
--   
--   5. Use of choice nodes:
--      You're making good use of choice nodes. Consider expanding this to offer more options in complex snippets.
--   
--   6. Autocmd optimization:
--      The `vim.api.nvim_create_autocmd` calls in the `cs` function could potentially be optimized to reduce the number of autocommands created.
--   
--   7. Error handling:
--      Consider adding error handling for snippet expansion, especially in more complex snippets.
--   
--   8. Snippet documentation:
--      Add brief comments explaining what each snippet does, especially for the more complex ones.
--   
--   9. Use of UVM-specific snippets:
--      Your UVM snippets are good. Consider expanding these to cover more UVM-specific patterns and boilerplate code.
--   
--   10. Filetype-specific configurations:
--       You've separated snippets by filetype, which is good. Consider creating filetype-specific configurations for snippet behavior.
--   
--   11. Performance optimization:
--       For larger snippet files, consider lazy loading or on-demand loading of snippets to improve startup time.
--   
--   12. Integration with other plugins:
--       Consider integrating your snippets with other plugins you use, such as LSP or completion plugins, for a more seamless experience.
--   
--   To implement these suggestions, you might want to start by creating a shared utility file for common functions, then work on standardizing your snippet format across files. After that, focus on expanding your use of dynamic nodes and choice nodes to create more flexible snippets.
--   
--   Would you like me to elaborate on any of these points or provide an example of how to implement one of these suggestions?
--   
--   ## Me
--   
--   > Context:
--   > - <buf>/tmp/nvim.sfollmer/j82fgi/0_nvim_snippets.md</buf>
--   
--   Provide an example of the shared utility file for common functions and how to use them in the various snippet files 
--   
--   ## CodeCompanion (OpenAI)
--   
--   Certainly! I'll create an example of a shared utility file and show how to use it in your snippet files. Here's how you can structure this:
--   
--   1. First, create a new file called `snippet_utils.lua` in your Neovim configuration directory. This file will contain common functions used across your snippet files.
--   
--   2. In `snippet_utils.lua`, add the following content:
--   
--   ```lua
--   local ls = require("luasnip")
--   local s = ls.snippet
--   local t = ls.text_node
--   local i = ls.insert_node
--   local f = ls.function_node
--   local d = ls.dynamic_node
--   local c = ls.choice_node
--   local fmt = require("luasnip.extras.fmt").fmt
--   
--   local M = {}
--   
--   -- Common function to create snippets
--   M.cs = function(trigger, nodes, opts)
--       local snippet = s(trigger, nodes)
--       local target_table = opts.autosnippet and ls.autosnippets or ls.snippets
--   
--       if opts.key then
--           local pattern = opts.pattern or "*"
--           vim.api.nvim_create_autocmd("InsertEnter", {
--               pattern = pattern,
--               callback = function()
--                   vim.keymap.set("i", opts.key, function()
--                       ls.snip_expand(snippet)
--                   end, { noremap = true, silent = true, buffer = true })
--               end,
--           })
--       end
--   
--       table.insert(target_table, snippet)
--   end
--   
--   -- Function to get current filename
--   M.get_filename = function()
--       return vim.fn.expand("%:t:r")
--   end
--   
--   -- Function to create a comment header
--   M.create_comment_header = function(text)
--       return t({
--           "//------------------------------------------------------------------------------",
--           "// " .. text,
--           "//------------------------------------------------------------------------------",
--       })
--   end
--   
--   return M
--   ```
--   
--   3. Now, in each of your snippet files (e.g., `lua.lua`, `javascript.lua`, etc.), you can use these utility functions. Here's an example of how to modify your `lua.lua` file:
--   
--   ```lua
--   local utils = require("snippet_utils")
--   local ls = require("luasnip")
--   local s = ls.snippet
--   local i = ls.insert_node
--   local t = ls.text_node
--   local f = ls.function_node
--   local c = ls.choice_node
--   local fmt = require("luasnip.extras.fmt").fmt
--   
--   -- Your snippets
--   utils.cs("fun", fmt(
--       [[
--       {header}
--       function {prefix}{name}({args})
--           {body}
--       end
--       ]],
--       {
--           header = utils.create_comment_header("Function: {name}"),
--           prefix = c(1, {t("local "), t("")}),
--           name = i(2, "function_name"),
--           args = i(3, ""),
--           body = i(4, "-- TODO: Implement function"),
--       }
--   ), { key = "jff" })
--   
--   utils.cs("for", fmt(
--       [[
--       for {var} = {start}, {end} do
--           {body}
--       end
--       ]],
--       {
--           var = i(1, "i"),
--           start = i(2, "1"),
--           ["end"] = i(3, "10"),
--           body = i(4, "-- TODO: Implement loop body"),
--       }
--   ), { key = "jfor" })
--   
--   -- More snippets...
--   
--   return {}
--   ```
--   
--   4. Apply similar changes to your other snippet files (`javascript.lua`, `verilog_systemverilog.lua`, etc.) to use the utility functions.
--   
--   This approach offers several benefits:
--   
--   1. Consistency: The `cs` function is now defined in one place, ensuring consistent behavior across all snippet files.
--   2. Reusability: Common functions like `create_comment_header` can be easily reused in multiple snippet files.
--   3. Maintainability: If you need to change how snippets are created or how file names are retrieved, you only need to update the utility file.
--   4. Cleaner snippet files: Your individual snippet files become cleaner and more focused on defining the actual snippets rather than utility functions.
--   
--   Remember to adjust the `require` path in each snippet file to correctly point to your `snippet_utils.lua` file based on your Neovim configuration structure.
--   
--   This is a starting point, and you can continue to add more utility functions to `snippet_utils.lua` as you identify common patterns in your snippet definitions.
--   
--   ## Me
--   
--   > Context:
--   >
--   > - <buf>/tmp/nvim.sfollmer/j82fgi/0_nvim_snippets.md</buf>
--   
--   I'm a bit confused.  For the require snippet_utils, does that snippet_utils need to be in the lua/config direcotry or can it be in the lua/snippets?
