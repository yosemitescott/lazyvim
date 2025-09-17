-- if true then return {} end
local utils = require('config.utils')

local M = {
    'vhda/verilog_systemverilog.vim',
    dependencies = {
        'pechorin/any-jump.vim',
        'preservim/tagbar',
        'liuchengxu/vista.vim',
    },
    ft   = {"verilog", "verilog_systemverilog", "systemverilog"},
    keys = {
        { "<leader>vj", "<cmd>AnyJump<CR>",                                              desc = "Jump Tag" },
        { "<leader>vJ", "<cmd>AnyJumpBack<CR>",                                          desc = "Jump Back" },
        { "<leader>vc", "0R//0",                                                       desc = "Comment out line" },
        { "<leader>vS", "<cmd>VerilogGotoInstanceStart<CR>",                             desc = "goto instance Start" },
        { "<leader>vi", "<cmd>VerilogFollowInstance<CR>",                                desc = "follow Instance start" },
        { "<leader>vr", "<cmd>VerilogReturnInstance<CR>",                                desc = "Return instance" },
        { "<leader>vp", "<cmd>VerilogFollowPort<CR>",                                    desc = "follow Port" },
        { "<leader>vT", "<cmd>TagbarToggle<CR>",                                         desc = "Toggle Tagbar" },
        { "<Leader>vt", "<cmd>lua ToggleColorColumn()<CR>",                              desc = "Toggle Color Column" },
        { "<leader>vf", "<cmd>VerilogFoldingRemove comment<CR> <BAR><cmd>foldopen!<CR>", desc = "Remove comment Folding" },
        { "<leader>vF", "<cmd>VerilogFoldingAdd comment<CR>",                            desc = "Add comment Folding" },
        { "<Leader>vb", "<cmd>lua ToggleBlockAlign()<CR>",                               desc = "Toggle Block Alignment" },
        { "<Leader>vu", "<cmd>lua AddUVMInfoMethodName()<CR>",                           desc = "Add UVM Method Identifier to UVM messages" },
        { "<Leader>ve", "<cmd>lua AddSVEndLabel()<CR>",                                  desc = "Add SystemVerilog End Method Identifier" },
        { "]v",         ':call tagbar#jumpToNearbyTag(1, "nearest", "s")<cr>',           desc = "Next verilog tag" },
        { "[v",         ':call tagbar#jumpToNearbyTag(-1, "nearest", "s")<cr>',          desc = "Previous verilog tag" },

        { "<Leader>vRd", [[:keeppatterns s/\$display\((.*\);/`uvm_info(get_name(), $sformatf\1, UVM_LOW)/<cr>]], desc = "Replace display with uvm_info"},
    },
    init = function()
--      vim.opt_local['smartindent'] = false
--      vim.opt_local['autoindent']  = true
        -- example of path
        --      vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')
        --
        local wk = require("which-key")
        wk.add({
            { "<leader>v",   group = "+systemverilog" },
            { "<leader>vR",  group = "+Replace" },
        })

        vim.g.any_jump_disable_default_keybindings = 1

        vim.opt.foldmethod  = "syntax"
        vim.opt.suffixesadd  = ".sv,.svh"
        vim.opt.path:append "./env/**, ./tests/**"
        vim.o.autoindent  = true
        vim.o.smartindent = false
        vim.b.commentstring = "//"
--      vim.o.colorcolumn = "139"

        vim.g.verilog_disable_indent_lst         = "eos"
        vim.g.verilog_syntax_fold_lst            = "comment"
        vim.g.verilog_efm_uvm_lst                = "all"
        vim.g.tagbar_width                       = 50
        vim.g.tagbar_sort                        = 0
        vim.g.tagbar_no_status_line              = 1
        vim.g.tagbar_stl_verilog_systemverilog   = true
        vim.b.verilog_indent_width               = 4
        vim.g.verilog_disable_constant_highlight = 1
        vim.b.verilog_indent_block_on_keyword    = 1
--      vim.g.verilog_verbose                    = true
        vim.lsp.set_log_level("info")

--      vim.g.verilog_instance_skip_last_coma    = 1
--      vim.g.tagbar_ctags_bin                   = 'uctags'
    end,

--  vim.filetype.add({
--      extension = {
--          v   = 'verilog_systemverilog',
--          svh = 'verilog_systemverilog',
--          sv  = 'verilog_systemverilog',
--      }
--  }),

}

-- Define a local table for our helper functions
local helpers = {}

helpers.ModeVerilog = function()
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4

    -- Add your Verilog-specific settings here
end

helpers.ModeSV = function()
    helpers.ModeVerilog()  -- Call the Verilog-compatible stuff

    -- Add your SystemVerilog-specific settings here
end

function M.config()                 -- Use config since it's not a LUA plugin

    -- Setup banners
--  helpers.setup_banners()

    -- Setup autocommands
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "verilog",
        callback = helpers.ModeVerilog,
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"systemverilog", "verilog_systemverilog"},
        callback = helpers.ModeSV,
    })

    -- File type detection
    vim.filetype.add({
        extension = {
            v   = 'verilog_systemverilog',
            svh = 'verilog_systemverilog',
            sv  = 'verilog_systemverilog',
        }
    })

    ToggleBlockAlign = function()
        if (vim.b.verilog_indent_block_on_keyword == nil) then
            vim.b.verilog_indent_block_on_keyword = 1
            vim.notify("Block Indent is on... YAY!")
        else
            vim.b.verilog_indent_block_on_keyword = nil
            vim.notify("Block Indent is off... BOO!")
        end
    end

    ToggleColorColumn = function()
        if (vim.o.colorcolumn == "") then
            vim.o.colorcolumn = "139"
        else
            vim.o.colorcolumn = ""
        end
    end

    AddUVMInfoMethodName = function()
        -- Get the current line number and content
        local row = vim.fn.line('.')
        local line = vim.fn.getline(row)

        -- Get the method name using the utility function
        local method_info = "{get_name(), ::" .. utils.get_current_method_name() .. "}"

        -- Extract the UVM macro name
        local uvm_ = line:match('(uvm_[%l]+)')
        if not uvm_ then
            print("No UVM macro found on the current line.")
            return
        end

        -- Construct the new text to insert
        local insert_text = string.format('%s(%s,', uvm_, method_info)

        -- Replace the first occurrence of a word followed by a parenthesis and comma
        local new_line = line:gsub('([%w_]+%(%),)', insert_text, 1)

        -- Replace the current line
        vim.fn.setline(row, new_line)

        -- Recenter the screen
        vim.cmd('normal! zz')
    end

    AddSVEndLabel = function()
        -- Get the current line number and content
        local row = vim.fn.line('.')
        local line = vim.fn.getline(row)

        -- Get the method name using the utility function
        local method_info = utils.get_current_method_name()

--      -- Go to mark `a` and add custom text
        local new_line = line ..  ': ' .. method_info

        -- Replace the current line
        vim.fn.setline(row, new_line)

        -- Recenter the screen
        vim.cmd('normal! zz')
    end


    vim.filetype.add({
        extension = {
            v   = 'verilog_systemverilog',
            svh = 'verilog_systemverilog',
            sv  = 'verilog_systemverilog',
        }
    })

    vim.g.tagbar_type_verilog_systemverilog = {
        ctagstype = 'SystemVerilog',
        kinds     = { 'b:blocks:0:1',
                    'f:functions:0:1',
                    'i:instances:1:1',
                    'm:modules:0:1',
                    't:tasks:0:1',
                    'A:assertions:1:0',
                    'C:classes:0:1',
                    'V:covergroups:0:1',
                    'I:interfaces:0:1',
                    'L:clocking blocks:1:0',
                    'M:modport:1:0',
                    'K:packages:0:1',
                    'P:programs:0:1',
                    'R:properties:0:0',
                    'T:typedefs:1:0'
                },
        sro         = '.',
        kind2scope  = { b = 'block',
                        f = 'function',
                        m = 'module',
                        t = 'task',
                        C = 'class',
                        V = 'covergroup',
                        I = 'interface',
                        K = 'package',
                        P = 'program',
                        R = 'property'
                        },
    },


    vim.cmd[[

    au FileType verilog               call ModeVerilog()
    au FileType systemverilog         call ModeSV()
    au FileType verilog_systemverilog call ModeSV()

    let g:cb_0 = '---------------------------------------'
    let g:cb_1 = '--------------------------------------------------------------------'
    let g:cb_2 = '--------------------------------------------------------------------------------------------------------------------'
    let g:cb_3 = '================================================================================='
    let g:cb_4 = '==========================================================================================================='

    function! DoubleSlashBannerComment(banner)
        let hg = synIDattr(synIDtrans(synID(line("."), col("$")-1, 1)), "name")
        return hg =~? 'comment' ? a:banner : "// " . a:banner
    endfunction

    function! DoubleDashBannerComment(banner)
        let hg = synIDattr(synIDtrans(synID(line("."), col("$")-1, 1)), "name")
        return hg =~? 'comment' ? a:banner : "-- " . a:banner
    endfunction

    function! PoundBannerComment(banner)
        let hg = synIDattr(synIDtrans(synID(line("."), col("$")-1, 1)), "name")
        return hg =~? 'comment' ? a:banner : "# " . a:banner
    endfunction

    function! ModeVerilog()

        "set softtabstop=2
        "set tabstop=2
        "set shiftwidth=2

        set softtabstop=4
        set tabstop=4
        set shiftwidth=4



        "set verbosefile=verbose.txt
        "let g:verilog_verbose="true"      " for t/s this plugin


    endfunction

    function! ModeSV()

        call ModeVerilog()  " Call the verilog compatable stuff

        "*******************************************
        "SystemVerilog Stuff
        "*******************************************
        "Disables indent for specific Verilog/SystemVerilog contexts.
        "The following contexts are supported:
        "       - `module`
        "       - `interface`
        "       - `class`
        "       - `package`
        "       - `covergroup`
        "       - `program`
        "       - `generate`
        "       - `sequence`
        "       - `property`
        "       - `method`
        "       - `preproc`
        "       - `conditional`
        "       - `eos`
        "   Note: The commands |:VerilogIndentAdd| and |:VerilogIndentRemove| are
        "   provided to allow an easier management of this variable.

"           let g:verilog_disable_indent_lst = "eos"
"           let b:verilog_indent_block_on_keyword = 1

        let g:verilog_syntax_custom = {
            \ 'comment' : [{
                \ 'match_start' : '^\s*//',
                \ 'match_end'   : '^\%(\s*//\)\@!',
                \ 'syn_argument': 'contains=verilogTodo,verilogDirective,@Spell keepend extend'
                \ }],
                \ }

        set foldmethod=syntax
        let g:verilog_syntax_fold_lst="comment"

    endfunction

    ]]
end


return M


