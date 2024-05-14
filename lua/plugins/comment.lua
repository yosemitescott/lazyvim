-- if true then return {} end

return {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
        local ft = require "Comment.ft"
--      local U = require("Comment.utils")
--
--      pre_hook = function(ctx)
--                      U.range.scol = 5
--                  end,
        --------------------------------------------------------------------
        --      Filetype                    Line      Block
        --------------------------------------------------------------------
        ft.set("lua",                   { "--%s" , "--[[%s]]" })
        ft.set("verilog_systemverilog", { "// %s", "/*%s*/"   })
    end,
}



-- Previous config for this plugin
--  local status_ok, comment = pcall(require, "Comment")
--  if not status_ok then
--  	return
--  end
--
--  comment.setup({
--      padding = true,
--      sticky  = true,
--      toggler = {
--          line  = 'gcc',          -- Line-comment  the current line
--          block = 'gbc',          -- Block-comment the current line
--      },
--      opleader = {
--          line  = 'gc',
--          block = 'gb',
--      },
--      extra = {
--          above = 'gcO',
--          below = 'gco',
--          eol   = 'gcA',
--      },
--      mappings = {
--          basic    = true,        -- Basic - Line-comment  the region contained in {motion} - gc[count]{motion}
--                                  -- Basic - Block-comment the region contained in {motion} - gb[count]{motion}
--          extra    = true,        -- Includes gco, gcO, gcA
--          extended = false,       -- Includes g>, g<, g>[count]{motion}, and g<[count]{motion}
--      },
--
--      post_hook = nil,            -- called after  commenting... Can be used to alter any formatting/newlines/etc.
--  --  pre_hook  = nil,            -- called before commenting... Can be used to determine the commentstring value
--      ignore    = nil,            -- Can be used to ignore using regex pattern
--  	pre_hook  = function(ctx)
--  		-- Only calculate commentstring for tsx filetypes
--  		if vim.bo.filetype == "typescriptreact" then
--  			local U = require("Comment.utils")
--
--  			-- Determine whether to use linewise or blockwise commentstring
--  			local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
--
--  			-- Determine the location where to calculate commentstring from
--  			local location = nil
--  			if ctx.ctype == U.ctype.blockwise then
--  				location = require("ts_context_commentstring.utils").get_cursor_location()
--  			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
--  				location = require("ts_context_commentstring.utils").get_visual_start_location()
--  			end
--
--  			return require("ts_context_commentstring.internal").calculate_commentstring({
--  				key = type,
--  				location = location,
--  			})
--  		end
--  	end,
--  })
--
--  local comment_ft = require "Comment.ft"
--  --------------------------------------------------------------------
--  --              Filetype                    Line      Block
--  --------------------------------------------------------------------
--  comment_ft.set("lua",                   { "--%s" , "--[[%s]]" })
--  comment_ft.set("verilog_systemverilog", { "// %s", "/*%s*/"   })

