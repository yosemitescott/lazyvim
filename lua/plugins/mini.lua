return {
    { "echasnovski/mini.pairs",      enabled = false },
    { "echasnovski/mini.comment",    enabled = false },
    { "echasnovski/mini.align",      config  = true, },
    { "echasnovski/mini.bracketed",  config  = true, },

--  { "echasnovski/mini.comment",
--      opts  = { options = {
--                              start_of_line = true,
--                          },
--      },
--  },
--  { "echasnovski/mini.align",      config  = function(_, opts) require("mini.align").    setup(opts) end, },
    --  {"echasnovski/mini.nvim", version = false },

--        {
--            "echasnovski/mini.hipatterns",
--            version = false,
--            event   = { "BufReadPre", "BufNewFile" },
--            opts    = function()
--                        local hi = require("mini.hipatterns")
--
--                        local words_bg = {
--                                SPF         = '#ff00ff',
--                                UVM_ERROR   = '#ff0000',
--                                UVM_FATAL   = '#ff0000',
--    --                          UVM_INFO    = '#00ff45',
--                                UVM_WARNING = '#ffff00',
--    --                          blue        = '#0000ff',
--                        }
--
--     ---                local words_line = {
--     ---                        SPF         = '#ff00ff',
--     ---                        UVM_ERROR   = '#ff0000',
--     ---                        UVM_FATAL   = '#ff0000',
--     ---                        UVM_INFO    = '#25ff45',
--     ---                        UVM_WARNING = '#ffff00',
--     ---                        blue        = '#0000ff',
--     ---                }
--                        local word_color_group_bg = function(_, match)
--                            local hex = words_bg[match]
--                            if hex == nil then return nil end
--                            return MiniHipatterns.compute_hex_color_group(hex, 'bg')
--                        end
--
--    --                  local word_color_group_line = function(_, match)
--    --                      local hex = words_line[match]
--    --                      if hex == nil then return nil end
--    --                      return MiniHipatterns.compute_hex_color_group(hex, 'line')
--    --                  end
--
--                        return {
--                            verilog = {
--                                enabled = true,
--                                ft      = { "systemverilog", "verilog", "verilog_systemverilog"},
--                                style   = "full",
--                            },
--                            highlighters = {
--                                -- Highlight standalone 'FIX', 'HACK', 'TODO', 'NOTE' SPF
--                                fixme = { pattern = "%f[%w]()FIX()%f[%W]",                 group = "MiniHipatternsFixme" },
--                                hack  = { pattern = "%f[%w]()HACK()%f[%W]",                group = "MiniHipatternsHack"  },
--                                todo  = { pattern = "%f[%w]()TODO()%f[%W]",                group = "MiniHipatternsTodo"  },
--                                note  = { pattern = "%f[%w]()NOTE()%f[%W]",                group = "MiniHipatternsNote"  },
--
--                                -- My patterns
--    --                          spf          = { pattern = '%f[%w]()SPF()%f[%W]' ,         group = 'TODO'                },
--    --                          uvm_error    = { pattern = '%f[%w]()UVM_ERROR()%f[%W]',    group = 'MiniHipatternsFixme' },
--    --                          uvm_fatal    = { pattern = '%f[%w]()UVM_FATAL()%f[%W]',    group = 'MiniHipatternsFixme' },
--    --                          uvm_warning  = { pattern = '%f[%w]()UVM_WARNING()%f[%W]',  group = 'MiniHipatternsHack'  },
--                                uvm_info     = { pattern = '%f[%w]()UVM_INFO()%f[%W]',     group = 'MiniHipatternsNote'  },
--
--                                word_color_bg = { pattern = '%S+', group = word_color_group_bg },
--    --                          word_color_line = { pattern = '%S+', group = word_color_group_line },
--
--                                -- Highlight hex color strings (`#rrggbb`) using that color
--                                hex_color = hi.gen_highlighter.hex_color({ style = "bg", priority = 2000 }),
--
--     --                         hex_color_line = hi.gen_highlighter.hex_color { style = "line", priority = 2000 },
--                            },
--                        }
--            end,
--            config = function(_, opts)
--                if opts.verilog == true then
--                    opts.verilog = {
--                        enabled = true,
--                        ft      = { "systemverilog", "verilog", "verilog_systemverilog"},
--                        style   = "full",
--                    }
--                end
--                require("mini.hipatterns").setup(opts)
--            end,
--        },


}
