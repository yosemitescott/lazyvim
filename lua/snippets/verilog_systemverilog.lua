local ls = require("luasnip") --{{{
local s = ls.s -- Snippet
local i = ls.i -- Insert node
local t = ls.t -- Text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("System Verilog Snippets", { clear = true })
local file_pattern = "*.sv*"

local function cs(trigger, nodes, opts) --{{{
    local snippet = s(trigger, nodes)
    local target_table = snippets

    local pattern = file_pattern
    local keymaps = {}

    if opts ~= nil then
        -- check for custom pattern
        if opts.pattern then
            pattern = opts.pattern
        end

        -- if opts is a string
        if type(opts) == "string" then
            if opts == "auto" then
                target_table = autosnippets
            else
                table.insert(keymaps, { "i", opts })
            end
        end

        -- if opts is a table
        if opts ~= nil and type(opts) == "table" then
            for _, keymap in ipairs(opts) do
                if type(keymap) == "string" then
                    table.insert(keymaps, { "i", keymap })
                else
                    table.insert(keymaps, keymap)
                end
            end
        end

        -- set autocmd for each keymap
        if opts ~= "auto" then
            for _, keymap in ipairs(keymaps) do
--              vim.notify({keymap})
                vim.api.nvim_create_autocmd("InsertEnter", {
                    pattern = pattern,
                    group = group,
                    callback = function()
                        vim.keymap.set(keymap[1], keymap[2], function()
                            ls.snip_expand(snippet)
                        end, { noremap = true, silent = true, buffer = true })
                    end,
                })
            end
        end
    end

    table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

-- End Refactoring --
local myFirstSnippet = s("myFirstSnippet", {
    t("YO.... this be my first snippet dog... "),
    i(1, "placeholder_text"),
    t(" this is another textnode"),
})
table.insert(snippets, myFirstSnippet)

--------------------------------------------------------------------
-- Function to return the current filename
--------------------------------------------------------------------
local filename = function()
    return f(function(_args, snip)
        local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
        return name[1] .. "::" or ""
    end)
end

--------------------------------------------------------------------
-- Function to return the comment string
--------------------------------------------------------------------
-- function comment_string()
--   local ft = require('Comment.ft')
--   local U = require('Comment.utils')
-- --local cmts = (ft.get(vim.bo.filetype, U.ctype.linewise))
-- --local cmts = ft.lang(vim.bo.filetype)
--   local cmts = ft.lang('verilog_systemverilog')
--   return cmts[0]
-- --return cmts
-- end

--------------------------------------------------------------------
-- Function snippet
--------------------------------------------------------------------
local sv_function = s(
    "fun",
    fmt(
        [[ 
                function {} {}{}({});
                    {}
                endfunction : {}

                ]],
        {
            c(1, {
                t("void"),
                t("int"),
                t("string"),
                i(1, "enter_type"),
            }),
            c(2, {
                filename(),
                t(""),
            }),
            i(3, "function_name"),
            i(4, "myArgs"),
            i(5, "// TODO"),
            rep(3),
        }
    )
)
table.insert(snippets, sv_function)

--------------------------------------------------------------------
-- For Loop snippet
--------------------------------------------------------------------
local sv_for_loop = s(
    "for",
    fmt(
        [[ 
                for ( {}{} = {}; {} {} {}; {}{} )
                    begin
                        {}
                    end // for {}

                ]],
        {
            c(1, {
                t("int "),
                t(""),
            }),
            i(2, "i"),
            i(3, "0"),
            rep(2),
            c(4, {
                t("<"),
                t("<="),
                t(">"),
                t(">="),
            }),
            i(5, "max_value"),
            rep(2),
            c(6, {
                t("++"),
                t("--"),
                i(1, "roll_your_own"),
            }),
            i(7, "// TODO"),
            rep(2),
        }
    )
)
table.insert(snippets, sv_for_loop)

--------------------------------------------------------------------
-- Task snippet
--------------------------------------------------------------------
local sv_task = s(
    "task",
    fmt(
        [[ 
        task {}{}({});
            {}
        endtask : {}

        ]],
        {
            c(1, {
                filename(),
                t(""),
            }),
            i(2, "task_name"),
            i(3, "myArgs"),
            i(4, "// TODO"),
            rep(2),
        }
    )
)
table.insert(snippets, sv_task)

--------------------------------------------------------------------
-- ALWAYS_FF snippet
--------------------------------------------------------------------
local sv_always_ff = s(
    "alff",
    fmt(
        [[
        always_ff @ ( posedge clk )
            begin
                {body}
            end  // always_ff

        ]],
        {
            body = i(1, "// TODO"),
        }
    )
)
table.insert(snippets, sv_always_ff)

--------------------------------------------------------------------
-- ALWAYS_FF snippet
--------------------------------------------------------------------
local sv_always_ff_reset = s(
    "alffr",
    fmt(
        [[
        always_ff @ ( posedge clk )
            begin
                if ( !rstn )
                    {rst_body}
                end  // if
            else
                begin
                    {body}
                end  // else
            end  // always_ff

        ]],
        {
            rst_body = i(1, "// RESET TODO"),
            body     = i(2, "// MAIN TODO"),
        }
    )
)
table.insert(snippets, sv_always_ff_reset)

--------------------------------------------------------------------
-- ALWAYS_COMB snippet
--------------------------------------------------------------------
local sv_always_comb = s(
    "alc",
    fmt(
        [[
        always_comb
            begin
                {body}
            end  // always_comb

        ]],
        {
            body = i(1, "// TODO"),
        }
    )
)
table.insert(snippets, sv_always_comb)

--------------------------------------------------------------------
-- IF snippet
--------------------------------------------------------------------
local sv_if = s(
    "if",
    fmt(
        [[
            if ( {args} )
                begin
                    {body}
                end  // if

        ]],
        {
            args = i(1, "logic_statment"),
            body = i(2, "// TODO"),
        }
    )
)
table.insert(snippets, sv_if)

--------------------------------------------------------------------
-- ELSE IF snippet
--------------------------------------------------------------------
local sv_else_if = s(
    "eif",
    fmt(
        [[
            else if ( {args} )
                begin
                    {body}
                end  // if

        ]],
        {
            args = i(1, "logic_statment"),
            body = i(2, "// TODO"),
        }
    )
)
table.insert(snippets, sv_else_if)

--------------------------------------------------------------------
-- ELSE snippet
--------------------------------------------------------------------
local sv_else = s(
    "else",
    fmt(
        [[
            else
                begin
                    {body}
                end  // else

        ]],
        {
            body = i(1, "// TODO"),
        }
    )
)
table.insert(snippets, sv_else)

--------------------------------------------------------------------
-- do while snippet
--------------------------------------------------------------------
local sv_while = s(
    "while",
    fmt(
        [[
            while ( {control} )
                begin
                    {body}
                end  // while

        ]],
        {
            control = i(1, "// TODO - control"),
            body    = i(2, "// TODO - body"),
        }
    )
)
table.insert(snippets, sv_while)

--------------------------------------------------------------------
-- do while snippet
--------------------------------------------------------------------
local sv_do_while = s(
    "dowhile",
    fmt(
        [[
            do
                begin
                    {body}
                end
            while ( {control} );

        ]],
        {
            body    = i(1, "// TODO - body"),
            control = i(2, "// TODO - control"),
        }
    )
)
table.insert(snippets, sv_do_while)

--------------------------------------------------------------------
-- TEST snippet
--------------------------------------------------------------------
-- local sv_test = s(
--         "comment",
--         fmt([[
--             {}
--         ]],
--         {f(comment_string()),
--         }
--        )
-- )
--
-- table.insert(snippets, sv_test)

--------------------------------------------------------------------
-- Commit Banner snippet
--------------------------------------------------------------------
-- local sv_comment = s(
--         "else",
--         fmt([[
--             else
--                 begin
--                     {body}
--                 end  // else
--
--         ]], {
--               body = i(1, "// TODO"),
--             }
--         )
-- )
-- table.insert(snippets, sv_else)

--------------------------------------------------------------------
-- `uvm_info snippet
--------------------------------------------------------------------
local uvm_info = s(
    "uvmi",
    fmt(
        [[
        `uvm_info({}, {}, {})

        ]],
        {
            c(1, {
                t("get_type_name()"),
                t("get_name()"),
                t('"SPF"'),
                sn(
                    1,
                    fmt(
                        [[
                    "{}"
                    ]],
                        i(1, "roll_your_own")
                    )
                ),
            }),
            c(2, {
                sn(
                    1,
                    fmt(
                        [[
                        $sformatf("{}", {})
                        ]],
                        {
                            i(1, "Enter String Format Stuff"),
                            i(2, "Variable(s)"),
                        }
                    )
                ),

                sn(
                    2,
                    fmt(
                        [[
                    "{}"
                    ]],
                        {
                            i(1, "Enter String Stuff"),
                        }
                    )
                ),
            }),
            c(3, {
                t("UVM_LOW"),
                t("UVM_MEDIUM"),
                t("UVM_HIGH"),
                t("UVM_DEBUG"),
                t("UVM_NONE"),
            }),
        }
    )
)

table.insert(snippets, uvm_info)

--------------------------------------------------------------------
-- `uvm_error snippet
--------------------------------------------------------------------
local uvm_error = s(
    "uvme",
    fmt(
        [[
        `{}({}, {})

        ]],
        {
            c(1, {
                t("uvm_error"),
                t("uvm_fatal"),
            }),
            c(2, {
                t("get_type_name()"),
                t("get_name()"),
                t('"SPF"'),
                sn(
                    1,
                    fmt(
                        [[
                    "{}"
                    ]],
                        i(1, "roll_your_own")
                    )
                ),
            }),
            c(3, {
                sn(
                    1,
                    fmt(
                        [[
                        $sformatf("{}", {})
                        ]],
                        {
                            i(1, "Enter String Format Stuff"),
                            i(2, "Variable(s)"),
                        }
                    )
                ),

                sn(
                    2,
                    fmt(
                        [[
                    "{}"
                    ]],
                        {
                            i(1, "Enter String Stuff"),
                        }
                    )
                ),
            }),
        }
    )
)

table.insert(snippets, uvm_error)

--------------------------------------------------------------------
-- `uvm_info snippet
--------------------------------------------------------------------
local uvm_component_verbosity = s(
    "compver",
    fmt(
        [[
        {}.set_report_verbosity_level({});
        ]],
        {
            i(1, "m_env.m_agent.m_driver"),
            c(2, {
                t("UVM_NONE"),
                t("UVM_LOW"),
                t("UVM_MEDIUM"),
                t("UVM_HIGH"),
                t("UVM_DEBUG"),
            }),
        }
    )
)

table.insert(snippets, component_verbosity)

--------------------------------------------------------------------
-- `uvm_info snippet
--------------------------------------------------------------------
local uvm_class = s(
    "uvmc",
    fmt(
        [[
        class {} extends {};
            {}({})

            function new (string name = "");
                super.new(name);
            endfunction : new

            {}

        endclass : {}

        ]],
        {
            i(1, "new_class_name"),
            i(2, "class_extended_from"),
            c(3, {
                t("`uvm_object_utils"),
                t("`uvm_component_utils"),
            }),
            rep(1),
            i(0, "// TODO"),
            rep(1),
        }
    )
)

table.insert(snippets, uvm_class)

--------------------------------------------------------------------
-- create sequence snippet
--------------------------------------------------------------------
local uvm_create_seq = s(
    "uvms",
    fmt(
        [[
        {} = {}::type_id::create("{}");
        if (!{}.randomize() ) `uvm_fatal(get_type_name(), "Failed to randomize {}")
        {}.init_start({});

        ]],
        {
            i(1, "m_seq_name"),
            i(2, "sequence_name"),
            rep(1),
            rep(1),
            rep(2),
            rep(1),
            i(3, "m_config_handle"),
        }
    )
)

table.insert(snippets, uvm_create_seq)

--------------------------------------------------------------------
-- randomize snippet
--------------------------------------------------------------------
local uvm_randomize = s(
    "uvmr",
    fmt(
        [[
        if ( !req.randomize() with {}
            {} == {}{};
        {})
            begin
                `uvm_fatal(get_type_name(), "Failed to randomize {}")
            end  // if

        ]],
        {
            t("{"),
            i(1, "transaction_variable"),
            c(2, {
                t("local::"),
                t("this::"),
                t(""),
                sn(
                    1,
                    fmt(
                        [[
                    "{}"
                    ]],
                        i(1, "roll_your_own")
                    )
                ),
            }),
            i(3, "some_value"),
            t("}"),
            i(4, "transaction_item_name"),
        }
    )
)

table.insert(snippets, uvm_randomize)

--------------------------------------------------------------------
-- create sequence snippet
--------------------------------------------------------------------
local disabled_fork = s(
    "disabledfork",
    fmt(
        [[
        fork
            begin   // Isolate the following as a single child process so the "disable fork" is at this level
                fork
                    begin
                        {}
                    end
                    begin
                        {}
                    end
                join_any
                disable fork;
            end
        join

        ]],
        {
            i(1, "// TODO - Branch 1"),
            i(2, "// TODO - Branch 2"),
        }
    )
)

table.insert(snippets, disabled_fork)

--------------------------------------------------------------------
-- try out the cs function
--------------------------------------------------------------------
cs(
    "endstatment",
    fmt(
        [[
        end // {}
        ]],
        {
            c(1, {
                t("if"),
                t("foreach"),
                t("forever"),
                t("repeat"),
                t("while"),
                t("initial"),
                t("always"),
                t("always_ff"),
                t("always_comb"),
            }),
        }
    ),
    "jj"
)

--------------------------------------------------------------------
-- create
--------------------------------------------------------------------
local myFirstAutoSnippet = s("dude", { t("This was auto triggered") })
-- local myFirstAutoSnippet = s("dude", f(comment_string()))

table.insert(autosnippets, myFirstAutoSnippet) -- autosnippets is the key word

return snippets, autosnippets
