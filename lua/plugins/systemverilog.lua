local M = {
    'vhda/verilog_systemverilog.vim',
    ft = {"verilog", "verilog_systemverilog", "systemverilog"},
}


function M.config()                 -- Use config since it's not a LUA plugin
    vim.filetype.add({
        extension = {
            v   = 'verilog_systemverilog',
            svh = 'verilog_systemverilog',
            sv  = 'verilog_systemverilog',
        }
    })

    vim.opt_local['smartindent'] = false
    vim.opt_local['autoindent'] = true

    vim.g.verilog_disable_indent_lst = "eos"
--  vim.g.verilog_instance_skip_last_coma = 1

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
    let g:cb_2 = '************************************************************************'
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


        "*******************************************
        "Remove VHDL Abbreviations in case
        "*******************************************
        "--------------------------------
        "Abbreviations for Verilog
        "--------------------------------
        iab <buffer> <expr> cb0 DoubleSlashBannerComment(g:cb_0)
        iab <buffer> <expr> cb1 DoubleSlashBannerComment(g:cb_1)
        iab <buffer> <expr> cb2 DoubleSlashBannerComment(g:cb_2)
        iab <buffer> <expr> cb3 DoubleSlashBannerComment(g:cb_3)
        iab <buffer> <expr> cb4 DoubleSlashBannerComment(g:cb_4)

        iab <buffer> cbox // _________________________________________________________________________________ //\| //\| //\|_________________________________________________________________________________

        iab <buffer> ea end  // always
        iab <buffer> ec endcase
        iab <buffer> ei end  // if
        iab <buffer> ee end  // else
        iab <buffer> eei end  // else if
        iab <buffer> ein end  // initial
        iab <buffer> efo end  // forever
        iab <buffer> ewh end  // while


        "*******************************************
        "Following an Instance/Port
        "*******************************************
        nnoremap <buffer> <leader>vis :VerilogGotoInstanceStart<CR>
        nnoremap <buffer> <leader>vfi :VerilogFollowInstance<CR>
        nnoremap <buffer> <leader>vri :VerilogReturnInstance<CR>
        nnoremap <buffer> <leader>vfp :VerilogFollowPort<CR>



        "   let b:verilog_indent_width = 2
        let b:verilog_indent_width = 4

        "set verbosefile=verbose.txt
        "let g:verilog_verbose="true"      " for t/s this plugin


        endfunction

        function! ModeSV()

            call ModeVerilog()  " Call the verilog compatable stuff

            "--------------------------------
            "Abbreviations for System Verilog
            "--------------------------------
            iab <buffer> aff always_ff @ ( posedge clk )
            iab <buffer> aco always_comb
            iab <buffer> eaf end // always_ff
            iab <buffer> eac end // always_comb

            iab <buffer> uvmnone +UVM_VERBOSITY=UVM_NONE
            iab <buffer> uvmlow +UVM_VERBOSITY=UVM_LOW
            iab <buffer> uvmmed +UVM_VERBOSITY=UVM_MEDIUM
            iab <buffer> uvmhigh +UVM_VERBOSITY=UVM_HIGH
            iab <buffer> uvmfull +UVM_VERBOSITY=UVM_FULL
            iab <buffer> uvmdebug +UVM_VERBOSITY=UVM_DEBUG

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
            let b:verilog_indent_block_on_keyword = 1

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


