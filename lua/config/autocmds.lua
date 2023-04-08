-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
--

--    nvim_create_augroup      — Create or get an augroup.
--    nvim_create_autocmd      — Create an autocmd.
--    nvim_del_augroup_by_id   — Delete an augroup by id.
--    nvim_del_augroup_by_name — Delete an augroup by name.
--    nvim_del_autocmd         — Delete an autocmd by id.
--    nvim_do_autocmd          — Do one autocmd.
--    nvim_get_autocmds        — Get autocmds that match the requirements.

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = { "*" },
--   command = [[%s/\s\+$//e]],
-- })

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.cmd([[
                  nnoremap <silent> <buffer> q :close<CR>
                  set nobuflisted
                ]])
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap  = true
        vim.opt_local.spell = true
    end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
    callback = function()
        vim.cmd("quit")
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        vim.lsp.codelens.refresh()
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        vim.cmd("hi link illuminatedWord LspReferenceText")
        require("lazyvim.plugins.lsp.format").autoformat = false
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count >= 5000 then
            vim.cmd("IlluminatePauseBuf")
        end
    end,
})


------------------------------------------------------------------------
-- The ones I added
------------------------------------------------------------------------
local splitwin = vim.api.nvim_create_augroup("ChangeWindows", { clear = true })
vim.api.nvim_create_autocmd({"WinEnter", "FocusGained", "InsertLeave"}, {
    group    = splitwin,
    callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.cursorline     = true
    end,
})

vim.api.nvim_create_autocmd({"WinLeave", "FocusLost", "InsertEnter"}, {
    group    = splitwin,
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline     = false
    end,
})


-- My Highlights
vim.cmd("hi def link MyTodo Todo")
vim.cmd("hi UVMF_HIGHLIGHT     guifg=#00d7af guibg=NONE guisp=NONE gui=bold ctermfg=43  ctermbg=NONE cterm=reverse")
vim.cmd("hi UVMF_PRAGMA        guifg=#8787ff guibg=NONE guisp=NONE gui=bold ctermfg=105 ctermbg=NONE cterm=underline")
vim.cmd("hi TrailingWhitespace ctermbg=red guibg=red")

vim.w.m1 = vim.fn.matchadd("TrailingWhitespace", '\\v\\s+$')
vim.w.m1 = vim.fn.matchadd("Todo",               '\\<SPF\\>')
--vim.w.m1 = vim.fn.matchadd("Todo",               '\\<NOTE\\>')
vim.w.m1 = vim.fn.matchadd("UVMF_HIGHLIGHT",     '\\<UVMF_CHANGE_ME\\>')
vim.w.m1 = vim.fn.matchadd("UVMF_PRAGMA",        '\\<pragma\\>')

-------------------------------------------
-- Autocmds to rewrite
--
--    if has("autocmd")
--      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
--    endif
--
--    augroup highlight_yank     " neovim
--      autocmd!
--      autocmd TextYankPost = silent! lua require 'vim.highlight'.on_yank()
--    augroup END
--
