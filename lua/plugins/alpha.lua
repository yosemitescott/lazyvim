if true then return {} end
local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

function M.opts()
    -- Taken from https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=New%20Glenn%0A
    --
    local dashboard = require("alpha.themes.dashboard")
    local alpha     = require("alpha")
    local logo = [[
        _______________________________________________________________________________________
        |                                                                                     |
        |    ███╗   ██╗███████╗██╗    ██╗     ██████╗ ██╗     ███████╗███╗   ██╗███╗   ██╗    |
        |    ████╗  ██║██╔════╝██║    ██║    ██╔════╝ ██║     ██╔════╝████╗  ██║████╗  ██║    |
        |    ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██║  ███╗██║     █████╗  ██╔██╗ ██║██╔██╗ ██║    |
        |    ██║╚██╗██║██╔══╝  ██║███╗██║    ██║   ██║██║     ██╔══╝  ██║╚██╗██║██║╚██╗██║    |
        |    ██║ ╚████║███████╗╚███╔███╔╝    ╚██████╔╝███████╗███████╗██║ ╚████║██║ ╚████║    |
        |    ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝╚═╝  ╚═══╝    |
        |     _______  ________         __         __  __         ___                         |
        |    / __/ _ \/ ___/ _ | ___   / /____    / /_/ /  ___   / _ \___ ___ ______ _____    |
        |   / _// ___/ (_ / __ |(_-<  / __/ _ \  / __/ _ \/ -_) / , _/ -_|_-</ __/ // / -_)   |
        |  /_/ /_/   \___/_/ |_/___/  \__/\___/  \__/_//_/\__/ /_/|_|\__/___/\__/\_,_/\__/    |
        |_____________________________________________________________________________________|]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",                     ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file",                      ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "󰄉  " .. " Recent files via telescope",    ":Telescope oldfiles <CR>"),
        dashboard.button("p", " " .. " Find project via telescope",    ":lua require('telescope').extensions.projects.projects()<CR>"),
        dashboard.button("g", " " .. " Find text via telescope",       ":Telescope live_grep <CR>"),
--      dashboard.button("c", " " .. " Config",                        ":e $MYVIMRC <CR>"),
        dashboard.button("c", " " .. " Config",                        ":Neotree ~/.config/nvim/lua <CR>"),
        dashboard.button("e", "󰂥 " .. " File Explore",                  ":Neotree <CR>"),
        dashboard.button("s", "󰑓 " .. " Restore Session",               [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy",                          ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit",                          ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl  = "Type"
    dashboard.section.header.opts.hl  = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val      = 8
    vim.b.miniindentscope_disable     = true

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
            pattern  = "AlphaReady",
            callback = function()
                require("lazy").show()
            end,
        })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
        pattern  = "LazyVimStarted",
        callback = function()
            local stats                  = require("lazy").stats()
            local ms                     = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(vim.cmd.AlphaRedraw)
        end,
    })
end

return M
