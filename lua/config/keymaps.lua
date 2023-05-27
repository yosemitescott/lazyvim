-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<leader>cc", [[:%s/\s\+$//e<cr>]], { noremap = true, silent = true, desc = "Clean Up Code" })
keymap(
    "n",
    "<leader>cC",
    [[:bufdo %s/\s\+$//e<cr>]],
    { noremap = true, silent = true, desc = "Clean Up Code - All buffers" }
)

keymap("n", "<leader>c=", [[gg=G]], { noremap = true, silent = true, desc = "Reformat all lines" })

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

--   -- Behave VIM
--   keymap('n', 'Y', "y$", opts)

-- Run Macro mappings - # stands for F (i.e. #2 is <F2>)
vim.keymap.set("n", "#2", "@a")
vim.keymap.set("n", "#3", "@b")
vim.keymap.set("n", "#4", "@c")
vim.keymap.set("n", "#5", "@d")

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
local wk = require("which-key")
wk.register({
    v = {
        name = "+systemVerilog",
    },
}, { prefix = "<leader>", mode = "n" })

wk.register({
    r = {
        name = "+replace",
    },
}, { prefix = "<leader>", mode = "n" })

--   ----------------------------------------------------------------------
--   align - Leader a was taken so e is used for "edit"
--   So far, these are only active during visual mode
--   ----------------------------------------------------------------------
wk.register({
    e = {
        name = "+align",
        ["1"] = { name = "+1st line" },
        m = { name = "+min space" },
        u = { name = "+UVM" },
    },
}, { prefix = "<leader>", mode = "v" })

keymap("v", "<Leader>ee", [[:!align <CR>]],         { noremap = true, silent = true, desc = "Align Default" })
keymap("v", "<Leader>e)", [[:!align \)<CR>]],       { noremap = true, silent = true, desc = "Align )" })
keymap("v", "<Leader>e#", [[:!align "\#"<CR>]],     { noremap = true, silent = true, desc = "Align #" })
keymap("v", "<Leader>e(", [[:!align \(<CR>]],       { noremap = true, silent = true, desc = "Align (" })
keymap("v", "<Leader>e[", [[:!align \[<CR>]],       { noremap = true, silent = true, desc = "Align [" })
keymap("v", "<Leader>e]", [[:!align \]<CR>]],       { noremap = true, silent = true, desc = "Align ]" })
keymap("v", "<Leader>e/", [[:!align //<CR>]],       { noremap = true, silent = true, desc = "Align /" })
keymap("v", "<Leader>e=", [[:!align =<CR>]],        { noremap = true, silent = true, desc = "Align =" })
keymap("v", "<Leader>e:", [[:!align :<CR>]],        { noremap = true, silent = true, desc = "Align :" })
keymap("v", "<Leader>e-", [[:!align \-<CR>]],       { noremap = true, silent = true, desc = "Align -" })
keymap("v", "<Leader>e{", [[:!align {<CR>]],        { noremap = true, silent = true, desc = "Align {" })
keymap("v", "<Leader>e}", [[:!align }<CR>]],        { noremap = true, silent = true, desc = "Align }" })

keymap("v", "<Leader>e1e", [[:!align -1<CR>]],      { noremap = true, silent = true, desc = "Align 1st Default" })
keymap("v", "<Leader>e1)", [[:!align -1 \)<CR>]],   { noremap = true, silent = true, desc = "Align 1st )" })
keymap("v", "<Leader>e1#", [[:!align -1 "\#"<CR>]], { noremap = true, silent = true, desc = "Align 1st #" })
keymap("v", "<Leader>e1(", [[:!align -1 \(<CR>]],   { noremap = true, silent = true, desc = "Align 1st (" })
keymap("v", "<Leader>e1[", [[:!align -1 \[<CR>]],   { noremap = true, silent = true, desc = "Align 1st [" })
keymap("v", "<Leader>e1]", [[:!align -1 \]<CR>]],   { noremap = true, silent = true, desc = "Align 1st ]" })
keymap("v", "<Leader>e1/", [[:!align -1 //<CR>]],   { noremap = true, silent = true, desc = "Align 1st /" })
keymap("v", "<Leader>e1=", [[:!align -1 =<CR>]],    { noremap = true, silent = true, desc = "Align 1st =" })
keymap("v", "<Leader>e1:", [[:!align -1 :<CR>]],    { noremap = true, silent = true, desc = "Align 1st :" })
keymap("v", "<Leader>e1-", [[:!align -1 \-<CR>]],   { noremap = true, silent = true, desc = "Align 1st -" })

keymap("v", "<Leader>eme", [[:!align -m<CR>]],      { noremap = true, silent = true, desc = "Align Min Default" })
keymap("v", "<Leader>em)", [[:!align -m \)<CR>]],   { noremap = true, silent = true, desc = "Align Min )" })
keymap("v", "<Leader>em#", [[:!align -m "\#"<CR>]], { noremap = true, silent = true, desc = "Align Min #" })
keymap("v", "<Leader>em(", [[:!align -m \(<CR>]],   { noremap = true, silent = true, desc = "Align Min (" })
keymap("v", "<Leader>em[", [[:!align -m \[<CR>]],   { noremap = true, silent = true, desc = "Align Min [" })
keymap("v", "<Leader>em]", [[:!align -m \]<CR>]],   { noremap = true, silent = true, desc = "Align Min ]" })
keymap("v", "<Leader>em/", [[:!align -m //<CR>]],   { noremap = true, silent = true, desc = "Align Min /" })
keymap("v", "<Leader>em=", [[:!align -m =<CR>]],    { noremap = true, silent = true, desc = "Align Min =" })
keymap("v", "<Leader>em:", [[:!align -m :<CR>]],    { noremap = true, silent = true, desc = "Align Min :" })
keymap("v", "<Leader>em-", [[:!align -m \-<CR>]],   { noremap = true, silent = true, desc = "Align Min -" })

keymap("v", "<Leader>eum", [[:!align " m_"<CR>]],   { noremap = true, silent = true, desc = "Align m_" })
keymap("v", "<Leader>eu:", [[:!align ::<CR>]],      { noremap = true, silent = true, desc = "Align ::" })
keymap("v", "<Leader>eut", [[:!align type<CR>]],    { noremap = true, silent = true, desc = "Align type" })

--   ----------------------------------------------------------------------
--   -- Save to temp files - Leader f is the file group
--   ----------------------------------------------------------------------
keymap( "v", "<Leader>fa", [[:w! $HOME/.config/nvim/files/tempa<CR>]],   { noremap = true, silent = true, desc = "Write to Temp File a" })
keymap( "v", "<Leader>fb", [[:w! $HOME/.config/nvim/files/tempb<CR>]],   { noremap = true, silent = true, desc = "Write to Temp File b" })
keymap( "v", "<Leader>fc", [[:w! $HOME/.config/nvim/files/tempc<CR>]],   { noremap = true, silent = true, desc = "Write to Temp File c" })
keymap( "v", "<Leader>fA", [[:w >> $HOME/.config/nvim/files/tempa<CR>]], { noremap = true, silent = true, desc = "Append to Temp File a" })
keymap( "v", "<Leader>fB", [[:w >> $HOME/.config/nvim/files/tempb<CR>]], { noremap = true, silent = true, desc = "Append to Temp File b" })
keymap( "v", "<Leader>fC", [[:w >> $HOME/.config/nvim/files/tempc<CR>]], { noremap = true, silent = true, desc = "Append to Temp File c" })
keymap( "n", "<Leader>fa", [[:r $HOME/.config/nvim/files/tempa<CR>]],    { noremap = true, silent = true, desc = "Read from Temp File a" })
keymap( "n", "<Leader>fb", [[:r $HOME/.config/nvim/files/tempb<CR>]],    { noremap = true, silent = true, desc = "Read from Temp File b" })
keymap( "n", "<Leader>fc", [[:r $HOME/.config/nvim/files/tempc<CR>]],    { noremap = true, silent = true, desc = "Read from Temp File c" })
