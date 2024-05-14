require("luasnip.session.snippet_collection").clear_snippets "verilog_systemverilog"

local ls   = require "luasnip"
local s    = ls.snippet
local c    = ls.choice_node
local d    = ls.dynamic_node
local i    = ls.insert_node
local t    = ls.text_node
local f    = ls.function_node
local sn   = ls.snippet_node

local fmta = require("luasnip.extras.fmt").fmta
local fmt  = require("luasnip.extras.fmt").fmt
local rep  = require("luasnip.extras").rep
local l    = require("luasnip.extras").lambda

local return_filename = function()
    return vim.fn.expand("%:r") .. "::"
end

local return_date = function()
    return os.date("%Y-%m-%d")      -- gets the date in the format YYYY-MM-DD
end

local headers = {
    ["new"] = {
        method = "Function",
        desc   = {
                 "Class constructor.",
                 "//",
                 "// Parameters:",
                 "// name   - Class object name",
                 "// parent - Handle of parent object",
                 },
                },

    ["build_phase"] = {
        method = "Function",
        desc   =  {
                  "UVM Build Phase.",
                  "//",
                  "// Parameters:",
                  "// phase - Handle to the current phase object",
                },
    },

    ["connect_phase"] = {
        method = "Function",
        desc   = {
                 "UVM Connect Phase.",
                  "//",
                  "// Parameters:",
                  "// phase - Handle to the current phase object",
                 },
    },

    ["run_phase"] = {
        method = "Task",
        desc   = {
                 "UVM Run Phase.",
                  "//",
                  "// Parameters:",
                  "// phase - Handle to the current phase object",
                 },
    },

    ["do_copy"] = {
        method = "Function",
        desc   = {
                 "Transaction copy execution method.",
                  "//",
                  "// Parameters:",
                  "// rhs - Object to copy",
                 },
    },

    ["do_compare"] = {
        method = "Function",
        desc   = {
                 "Transaction comparison execution method.",
                  "//",
                  "// Parameters:",
                  "// rhs      - Object to compare",
                  "// comparer - Comparer object handle",
                  "//",
                  "// Returns:",
                  "// bit      - 1'b1: Transactions match; 1'b0: Transactions do not match",
                 },
    },

    ["convert2string"] = {
        method = "Function",
        desc   = {
                 "Convert object attributes to a string.",
                  "//",
                  "// Returns:",
                  "// string - String representation of this object",
                 },
    },

    ["differences2string"] = {
        method = "Function",
        desc   = {
                 " Print out only the differences from compares",
                  "//",
                  " // Returns:",
                  " // string - String result of the differences",
                 },
    },

    ["body"] = {
        method = "Task",
        desc   = {
                 "Body Task",
                  "//",
                  "// Parameters:",
                  "// None",
                 },
    },

    ["do_print"] = {
        method = "Function",
        desc   = {
                 "Transaction print execution method.",
                  "//",
                  "// Parameters:",
                  "// printer - Printer object handle",
                 },
    },

    ["init_start"] = {
        method = "Task",
        desc   = {
                  "Init Start Routine grabs configuration of config and starts itself",
                  "//",
                  "// Parameters:",
                  "//  m_config - handle to agent config which contains the sequencer handle",
                 },
    },
}

local method_return_value = function(args)
    local entry = headers[args[1][1]]["method"]

    return sn(
        nil,
        t(entry)
    )
end

local descr_return_value = function(args)
    local entry = headers[args[1][1]]["desc"]

    return sn(
        nil,
        t(entry)
    )
end

-- local choice_nodes = function()
-- 
-- --  local nodes = {}
-- --  for index,v in ipairs(keys) do
-- --      table.insert(
-- --          nodes,
-- --          "t(v),"
-- --      )
-- --  end
--     return sn(nil, c(1, {t("a"), t("b")}))
-- end

ls.add_snippets("verilog_systemverilog", {
    s(
        "uvm_header",
        fmta(
            [[
            //------------------------------------------------------------------------------
            // <method>: <name>
            // <descr>
            //------------------------------------------------------------------------------
            <finish>
            ]],
            {
                name   = c(1, {
                            t("new"),
                            t("build_phase"),
                            t("connect_phase"),
                            t("run_phase"),
                            t("do_copy"),
                            t("do_compare"),
                            t("convert2string"),
                            t("differences2string"),
                            t("body"),
                            t("init_start"),
                            t("do_print"),
                }),
                method = d(2, method_return_value, 1),
                descr  = d(3, descr_return_value, 1),
                finish = i(0),
            }
        )
    ),


    s(
        "uvm_fun",
        fmt(
            [[ 
            //------------------------------------------------------------------------------
            // Function : {}
            // {}
            //
            // Parameters:
            // {}
            // TODO: Complete function arguments
            //
            //------------------------------------------------------------------------------
            function {} {}{}({});
                {}
            endfunction : {}
            {}
            ]],
            {
                rep(3),
                i(6, " TODO: Function Description"),
                rep(4),
                c(1, {
                    t("void"),
                    t("int"),
                    t("string"),
                    i(1, "enter_type"),
                }),
                c(2, {
                    f(return_filename, {}),
                    t(""),
                }),
                i(3, "function_name"),
                i(4, "myArgs"),
                i(5, "// TODO"),
                rep(3),
                i(0),
            }
        )
    ),


    s(
        "bvm_header",
        fmta(
            [[ 
            // ============================================================================
            //
            //  Blue Origin Proprietary & Confidential
            //
            //  INFORMATION SUBJECT TO EXPORT CONTROL LAWS
            //  This work and any attachments hereto may contain information subject to
            //  United States export control laws, and which may not be exported from the
            //  United States, or otherwise released or disclosed to foreign nationals
            //  inside or outside the United States, without first obtaining an export
            //  license from the U.S. Government under the International Traffic in Arms
            //  Regulations (ITAR) and/or the Export Administration Regulations (EAR).
            //  Violation of U.S. export controls is subject to imprisonment and/or fine.
            //
            //  NOTICE OF PROPRIETARY INFORMATION
            //  Blue Origin proprietary information is disclosed herein. By accepting this
            //  work recipient agrees that neither this work and any attachments, nor the
            //  information disclosed herein, nor any part thereof shall be reproduced or
            //  transferred to other works, or used or disclosed to others for any purpose
            //  except as specifically authorized in writing by Blue Origin.
            //
            //  Author: Scott Follmer (sfollmer@blueorigin.com)
            //  Date: <date>
            //  Description: <desc>
            //
            // ============================================================================
            <finish>
            ]],
            {
                date = c(1, {
                            f(return_date, {}),
                            t(""),
                        }),
                desc = i(2, "TODO: - Add Description"),
                finish = i(0),
            }
        )
    ),


    s(
        "uvm_fun_header",
        fmt(
            [[ 
            //------------------------------------------------------------------------------
            // Function : {}
            // {}
            //
            // Parameters:
            // {}
            //------------------------------------------------------------------------------
            {}
            ]],
            {
                i(1, "function_name"),
                i(2, "// TODO"),
                i(3, "myArgs"),
                i(0),
            }
        )
    ),

    s(
        "uvm_task_header",
        fmt(
            [[ 
            //------------------------------------------------------------------------------
            // Task : {}
            // {}
            //
            // Parameters:
            // {}
            //------------------------------------------------------------------------------
            {}
            ]],
            {
                i(1, "task_name"),
                i(2, "// TODO"),
                i(3, "myArgs"),
                i(0),
            }
        )
    ),



--      fmta(
--      [[ 
--      //------------------------------------------------------------------------------
--      // Function : <title>
--      // <desr>
--      //
--      // Parameters:
--      // 
--      // TODO: Complete function arguments
--      //
--      //------------------------------------------------------------------------------
--      function <returns> {}{}({});
--          {}
--      endfunction : {}
--      <finish>
--      ]],
--      {
--          title   = rep(3),
--          desc    = i(6, " TODO: Function Description"),
--          returns = c(1, {
--                        t("void"),
--                        t("int"),
--                        t("string"),
--                        i(1, "enter_type"),
--                    }),
--          c(2, {
--              t(l.TM_FILENAME),
--              t(""),
--          }),
--          i(3, "function_name"),
--          i(4, "myArgs"),
--          i(5, "// TODO"),
--          rep(3),
--          finish = i(0),
--      }
--      )
--  ),

--  s("ie", fmta("if err != nil {\n\treturn <err>\n}", { err = i(1, "err") })),
})
