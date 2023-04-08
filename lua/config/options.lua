-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
--
--

local options = {
    backup             = false,         -- creates a backup file

    clipboard          = "unnamed",     -- Do not allow neovim to access the system clipboard
    cmdheight          = 2,             -- more space in the neovim command line for displaying messages spf
    conceallevel       = 0,             -- so that `` is visible in markdown files
    fileencoding       = "utf-8",       -- the encoding written to a file
    hlsearch           = true,          -- highlight all matches on previous search pattern spf
    ignorecase         = true,          -- ignore case in search patterns spf
    mouse              = "a",           -- allow the mouse to be used in neovim spf
    pumheight          = 10,            -- pop up menu height
    showtabline        = 2,             -- always show tabs
    smartcase          = true,          -- smart case spf
    smartindent        = true,          -- make indenting smarter again
    splitbelow         = true,          -- force all horizontal splits to go below current window spf
    splitright         = true,          -- force all vertical splits to go to the right of current window spf
    swapfile           = false,         -- creates a swapfile
    termguicolors      = true,          -- set term gui colors (most terminals support this)
    undofile           = true,          -- enable persistent undo spf
    writebackup        = false,         -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab          = true,          -- convert tabs to spaces spf
    shiftwidth         = 4,             -- the number of spaces inserted for each indentation spf
    tabstop            = 4,             -- insert 2 spaces for a tab spf
    cursorline         = true,          -- highlight the current line spf
    number             = true,          -- set numbered lines spf
    relativenumber     = true,          -- set relative numbered lines spf
    numberwidth        = 4,             -- set number column width to 2 {default 4}
    signcolumn         = "yes",         -- always show the sign column, otherwise it would shift the text each time
    wrap               = false,         -- display lines as one long line spf
    linebreak          = true,          -- companion to wrap, don't split words
    sidescrolloff      = 8,             -- minimal number of screen columns either side of cursor if wrap is `false`
    whichwrap          = "bs<>[]hl",    -- which "horizontal" keys are allowed to travel to prev/next line
    background         = "dark",        -- Chooses dark version of colorschemes

--  completeopt        = { "menuone", "noselect" },	-- mostly just for cmp
--  showmode           = false,                    	-- we don't need to see things like -- INSERT -- anymore (if false)
--  timeoutlen         = 1000,                     	-- time to wait for a mapped sequence to complete (in milliseconds) spf
--  updatetime         = 300,                      	-- faster completion (4000ms default)  50? spf
--  scrolloff          = 1,                        	-- minimal number of screen lines to keep above and below the cursor spf
--  guifont            = "monospace:h17",          	-- the font used in graphical neovim applications
--  eob                =" "                         -- show empty lines at the end of a buffer as ` ` {default `~`}
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.shortmess:append("c") -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.iskeyword:append("-") -- treats words with `-` as single words - hyphenated words recognized by searches
vim.opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached



--vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
--  don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
--vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
--
--
-- Default values from lazy
-- - This file is automatically loaded by plugins.config

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- vim.opt.autowrite = true -- enable auto write
-- vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
-- vim.opt.cmdheight = 1
-- vim.opt.completeopt = "menu,menuone,noselect"
-- vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
-- vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
-- vim.opt.cursorline = true -- Enable highlighting of the current line
-- vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- vim.opt.grepformat = "%f:%l:%c:%m"
-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.guifont = "FiraCode Nerd Font:h11"
-- vim.opt.hidden = true -- Enable modified buffers in background
-- vim.opt.ignorecase = true -- Ignore case
-- vim.opt.inccommand = "nosplit" -- preview incremental substitute
-- vim.opt.joinspaces = false -- No double spaces with join after a dot
-- vim.opt.laststatus = 0
-- vim.opt.list = true -- Show some invisible characters (tabs...
-- vim.opt.mouse = "a" -- enable mouse mode
-- vim.opt.number = true -- Print line number
-- vim.opt.pumblend = 10 -- Popup blend
-- vim.opt.pumheight = 10 -- Maximum number of entries in a popup
-- vim.opt.relativenumber = true -- Relative line numbers
-- vim.opt.scrolloff = 4 -- Lines of context
-- vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- vim.opt.shiftround = true -- Round indent
-- vim.opt.shiftwidth = 2 -- Size of an indent
-- vim.opt.showmode = false -- dont show mode since we have a statusline
-- vim.opt.sidescrolloff = 8 -- Columns of context
-- vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- vim.opt.smartcase = true -- Don't ignore case with capitals
-- vim.opt.smartindent = true -- Insert indents automatically
-- vim.opt.spelllang = { "en" }
-- vim.opt.splitbelow = true -- Put new windows below current
-- vim.opt.splitright = true -- Put new windows right of current
-- vim.opt.tabstop = 2 -- Number of spaces tabs count for
-- vim.opt.termguicolors = true -- True color support
-- vim.opt.timeoutlen = 300
-- vim.opt.undofile = true
-- vim.opt.undolevels = 10000
-- vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
-- vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
-- vim.go.winminwidth = 5 -- minimum window width
-- vim.opt.wrap = false -- Disable line wrap
--
-- if vim.fn.has("nvim-0.9.0") == 1 then
--   vim.opt.splitkeep = "screen"
--   vim.o.shortmess = "filnxtToOFWIcC"
-- end
--
-- -- fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0
