-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local wk = require("which-key")

-- Delete default keymaps
-- vim.api.nvim_del_keymap("n", "<S-L>")
-- vim.api.nvim_del_keymap("n", "<S-H>")
-- vim.api.nvim_del_keymap("n", "gt")
-- vim.api.nvim_del_keymap("n", "gT")

vim.keymap.del("n", "<S-L>")
vim.keymap.del("n", "<S-H>")
--vim.keymap.del("n", "gt")
--vim.keymap.del("n", "gT")

--   --Remap space as leader key
--   keymap("", "<Space>", "<Nop>", opts)

--   -- Modes
--   -- n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
--   -- i  Insert mode map. Defined using ':imap' or ':inoremap'.
--   -- v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
--   -- x  Visual block mode map. Defined using ':xmap' or ':xnoremap'.
--   -- s  Select mode map. Defined using ':smap' or ':snoremap'.
--   -- c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
--   -- o  Operator pending mode map. Defined using ':omap' or ':onoremap'.
--   -- t  term_mode

--   ----------------------------------------------------------------------
--   -- Normal --
--   ----------------------------------------------------------------------
--   -- Better window navigation
--   keymap("n", "<C-h>", "<C-w>h",  opts)
--   keymap("n", "<C-j>", "<C-w>j",  opts)
--   keymap("n", "<C-k>", "<C-w>k",  opts)
--   keymap("n", "<C-l>", "<C-w>l",  opts)

-- Hopefully temp cuz my iabbr are not working after just pressing a return
keymap("i", "<CR>", "<c-]><CR>", opts)

-- These remap the builtins' behavior cause the screen to center at the cursor line
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

--   -- Resize with arrows
--   keymap("n", "<C-Up>",    ":resize +2<CR>", opts)
--   keymap("n", "<C-Down>",  ":resize -2<CR>", opts)
--   keymap("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
--   keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
--keymap("n", "<S-l>", ":bnext<CR>", opts)
--keymap("n", "<S-h>", ":bprevious<CR>", opts)
--keymap("n", "<TAB>", ":bnext<CR>", opts)
--keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Clear highlights
--keymap("n", "<leader>z", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear Search Highlight" })

--   -- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", { noremap = true, silent = true, desc = "Close/Delete Buffer" })

-- Delete Trailing Whitespace
keymap("n", "<leader>cc", [[mr:%s/\s\+$//e<cr>`r]],   { noremap = true, silent = true, desc = "Clean Up Code" })
keymap("n", "<leader>cC", [[:bufdo %s/\s\+$//e<cr>]], { noremap = true, silent = true, desc = "Clean Up Code - All buffers" })
keymap("n", "<leader>c=", [[gg=G]],                   { noremap = true, silent = true, desc = "Reformat all lines" })
keymap("n", "<leader>cp", [[:ProjectRoot]],           { noremap = true, silent = true, desc = "add Project" })

-- Remove Color codes from UVM Logs
--keymap("n", "<leader>cu", "<cmd>%s/[[0-9;]*m//g<cr>", { noremap = true, silent = true, desc = "Clean Up UVM color codes" })
keymap("n", "<leader>cu", [[mr:%s/<C-v><esc>[[0-9;]\{2,}m//g<cr>`r]], { noremap = true, silent = true, desc = "Clean Up UVM color codes" })

--   command = [[%s/\s\+$//e]],

--   -- Create Splits
--   keymap('n', 'vgf',   '<C-w>vgf', opts)
--   keymap('n', '<M-f>', '<C-W>vgf', opts)
--   keymap('n', '<M-]>', '<C-W>v<c-]>', opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move Line Up" })
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move Line Down" })

-- FINDING AND REPLACING
-- Press * to search for the term under the cursor or in a visual selection and
-- then press a key below to replace all instances of it in the current file.
keymap("n", "<leader>s*", ":%s/<C-r><C-w>/", { noremap = true, silent = true, desc = "Search/Replace Dialogue" })
keymap("n", "<leader>s8", ":%s/\\<<C-r><C-w>\\>/", { noremap = true, silent = true, desc = "Search/Replace Dialogue Boundary" })

--   -- Behave VIM
--   keymap('n', 'Y', "y$", opts)

-- Run Macro mappings
vim.keymap.set("n", "<F2>", "@a")
vim.keymap.set("n", "<F3>", "@b")
vim.keymap.set("n", "<F4>", "@c")
vim.keymap.set("n", "<F5>", "@d")

-- Yank 
wk.add({
    { "<leader>y", '"+y', mode = { "v"}, desc = "Yank to System Clipboard" },
    { "<leader>y", '"+p', mode = { "n"}, desc = "Paste from System Clipboard" },
})


--   ----------------------------------------------------------------------
--   -- Insert --
--   ----------------------------------------------------------------------
--   -- Press jk fast to exit insert mode
--   keymap("i", "jk", "<ESC>", opts)
--   keymap("i", "kj", "<ESC>", opts)

-- Undo break points - put a common character to break up the undos
-- keymap("i", ",", ",<c-g>u", opts)        These are already in LazyVim
-- keymap("i", ".", ".<c-g>u", opts)
-- keymap("i", ";", ";<c-g>u", opts)
keymap("i", "=", "=<c-g>u", opts)

-- Move text up and down
-- keymap("i", "<C-j>", "<esc>:m .+1<CR>==", opts)
-- keymap("i", "<C-k>", "<esc>:m .-2<CR>==", opts)

--   ----------------------------------------------------------------------
--   -- Visual --
--   ----------------------------------------------------------------------
--   -- Stay in indent mode
--   keymap("v", "<", "<gv", opts)
--   keymap("v", ">", ">gv", opts)
--   keymap("v", "H", "<gv", opts)
--   keymap("v", "L", ">gv", opts)


-- Holds onto the paste register after puts
keymap("v", "p", '"_dP', opts)

--   ----------------------------------------------------------------------
--   -- Visual Block -- Move text up and down
--   ----------------------------------------------------------------------
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

--   ----------------------------------------------------------------------
--   -- NvimTree
--   ----------------------------------------------------------------------
--   keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opts)

--   ----------------------------------------------------------------------
--   -- DAP
--   ----------------------------------------------------------------------
--   keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
--   keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",          opts)
--   keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",         opts)
--   keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",         opts)
--   keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>",          opts)
--   keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",       opts)
--   keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",          opts)
--   keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>",          opts)
--   keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>",         opts)

--
--   ----------------------------------------------------------------------
--   These provide labels 
--   ----------------------------------------------------------------------
wk.add({
    { "<leader>r", group = "+replace (Muren)" },
})

--   ----------------------------------------------------------------------
--   align - Leader a was taken so e is used for "edit"
--   So far, these are only active during visual mode
--   ----------------------------------------------------------------------
wk.add({
    { "<leader>e", mode = "v", group = "+align" },
    { "<leader>ee", [[:!align <CR>]],     mode = "v", desc = "Align Default" },
    { "<leader>e)", [[:!align \)<CR>]],   mode = "v", desc = "Align )" },
    { "<leader>e#", [[:!align "\#"<CR>]], mode = "v", desc = "Align #" },
    { "<leader>e(", [[:!align \(<CR>]],   mode = "v", desc = "Align (" },
    { "<leader>e[", [[:!align \[<CR>]],   mode = "v", desc = "Align [" },
    { "<leader>e]", [[:!align \]<CR>]],   mode = "v", desc = "Align ]" },
    { "<leader>e/", [[:!align //<CR>]],   mode = "v", desc = "Align /" },
    { "<leader>e=", [[:!align =<CR>]],    mode = "v", desc = "Align =" },
    { "<leader>e:", [[:!align :<CR>]],    mode = "v", desc = "Align :" },
    { "<leader>e-", [[:!align \-<CR>]],   mode = "v", desc = "Align -" },
    { "<leader>e{", [[:!align {<CR>]],    mode = "v", desc = "Align {" },
    { "<leader>e}", [[:!align }<CR>]],    mode = "v", desc = "Align }" },
    { "<leader>e.", [[:!align .<CR>]],    mode = "v", desc = "Align ." },
    { "<leader>e,", [[:!align ,<CR>]],    mode = "v", desc = "Align ," },

    { "<leader>e1", mode = "v", group = "+1st line" },
    { "<leader>e1e", [[:!align -1<CR>]],      mode = "v", desc = "Align 1st Default" },
    { "<leader>e1)", [[:!align -1 \)<CR>]],   mode = "v", desc = "Align 1st )" },
    { "<leader>e1#", [[:!align -1 "\#"<CR>]], mode = "v", desc = "Align 1st #" },
    { "<leader>e1(", [[:!align -1 \(<CR>]],   mode = "v", desc = "Align 1st (" },
    { "<leader>e1[", [[:!align -1 \[<CR>]],   mode = "v", desc = "Align 1st [" },
    { "<leader>e1]", [[:!align -1 \]<CR>]],   mode = "v", desc = "Align 1st ]" },
    { "<leader>e1/", [[:!align -1 //<CR>]],   mode = "v", desc = "Align 1st /" },
    { "<leader>e1=", [[:!align -1 =<CR>]],    mode = "v", desc = "Align 1st =" },
    { "<leader>e1:", [[:!align -1 :<CR>]],    mode = "v", desc = "Align 1st :" },
    { "<leader>e1-", [[:!align -1 \-<CR>]],   mode = "v", desc = "Align 1st -" },
    { "<leader>e1{", [[:!align -1 {<CR>]],    mode = "v", desc = "Align 1st {" },
    { "<leader>e1}", [[:!align -1 }<CR>]],    mode = "v", desc = "Align 1st }" },
    { "<leader>e1.", [[:!align -1 .<CR>]],    mode = "v", desc = "Align 1st ." },

    { "<leader>em", mode = "v", group = "+min space" },
    { "<leader>eme", [[:!align -m<CR>]],      mode = "v", desc = "Align Min Default" },
    { "<leader>em)", [[:!align -m \)<CR>]],   mode = "v", desc = "Align Min )" },
    { "<leader>em#", [[:!align -m "\#"<CR>]], mode = "v", desc = "Align Min #" },
    { "<leader>em(", [[:!align -m \(<CR>]],   mode = "v", desc = "Align Min (" },
    { "<leader>em[", [[:!align -m \[<CR>]],   mode = "v", desc = "Align Min [" },
    { "<leader>em]", [[:!align -m \]<CR>]],   mode = "v", desc = "Align Min ]" },
    { "<leader>em/", [[:!align -m //<CR>]],   mode = "v", desc = "Align Min /" },
    { "<leader>em=", [[:!align -m =<CR>]],    mode = "v", desc = "Align Min =" },
    { "<leader>em:", [[:!align -m :<CR>]],    mode = "v", desc = "Align Min :" },
    { "<leader>em-", [[:!align -m \-<CR>]],   mode = "v", desc = "Align Min -" },
    { "<leader>em{", [[:!align -m {<CR>]],    mode = "v", desc = "Align Min {" },
    { "<leader>em}", [[:!align -m }<CR>]],    mode = "v", desc = "Align Min }" },
    { "<leader>em.", [[:!align -m .<CR>]],    mode = "v", desc = "Align Min ." },

    { "<leader>eu", mode = "v", group = "+UVM" },
    { "<leader>eum", [[:!align " m_"<CR>]],   mode = "v", desc = "Align m_" },
    { "<leader>eu:", [[:!align ::<CR>]],      mode = "v", desc = "Align ::" },
    { "<leader>eut", [[:!align type<CR>]],    mode = "v", desc = "Align type" },
    { "<leader>euT", [[:!align this<CR>]],    mode = "v", desc = "Align this" },
})

--   ----------------------------------------------------------------------
--   -- Save to temp files - Leader f is the file group
--   ----------------------------------------------------------------------
wk.add({
    { "<leader>j", mode = {"n", "v"}, group = "+temp file fun" },
    { "<leader>ja", [[:w! $HOME/.config/nvim/files/tempa<CR>]],   mode = "v", desc = "Write to Temp File a" },
    { "<leader>jb", [[:w! $HOME/.config/nvim/files/tempb<CR>]],   mode = "v", desc = "Write to Temp File b" },
    { "<leader>jc", [[:w! $HOME/.config/nvim/files/tempc<CR>]],   mode = "v", desc = "Write to Temp File c" },
    { "<leader>jA", [[:w >> $HOME/.config/nvim/files/tempa<CR>]], mode = "v", desc = "Append to Temp File a" },
    { "<leader>jB", [[:w >> $HOME/.config/nvim/files/tempb<CR>]], mode = "v", desc = "Append to Temp File b" },
    { "<leader>jC", [[:w >> $HOME/.config/nvim/files/tempc<CR>]], mode = "v", desc = "Append to Temp File c" },
    { "<leader>ja", [[:r $HOME/.config/nvim/files/tempa<CR>]],    mode = "n", desc = "Read from Temp File a" },
    { "<leader>jb", [[:r $HOME/.config/nvim/files/tempb<CR>]],    mode = "n", desc = "Read from Temp File b" },
    { "<leader>jc", [[:r $HOME/.config/nvim/files/tempc<CR>]],    mode = "n", desc = "Read from Temp File c" },
})

--   ----------------------------------------------------------------------
--   diff options
--   ----------------------------------------------------------------------
wk.add({
    { "<leader>d", mode = "n", group = "+diff" },
    { "<Leader>dw", "<cmd>set diffopt+=iwhiteall<CR>",      mode = "n", desc = "Add ignore all whitespace" },
    { "<Leader>dW", "<cmd>set diffopt-=iwhiteall<CR>",      mode = "n", desc = "Remove ignore all whitespace" },
    { "<Leader>dc", "<cmd>set diffopt+=icase<CR>",          mode = "n", desc = "Add ignore case" },
    { "<Leader>dC", "<cmd>set diffopt-=icase<CR>",          mode = "n", desc = "Remove ignore case" },
    { "<Leader>db", "<cmd>set diffopt+=iblank<CR>",         mode = "n", desc = "Add ignore blank" },
    { "<Leader>dB", "<cmd>set diffopt-=iblank<CR>",         mode = "n", desc = "Remove ignore blank" },
})
