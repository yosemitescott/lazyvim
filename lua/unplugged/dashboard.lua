if true then return {} end
return {
    "nvimdev/dashboard-nvim",
    enable = false,
    event = "VimEnter",
    opts = function()
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
         |_____________________________________________________________________________________|
    ]]

        logo = string.rep("\n", 8) .. logo .. "\n\n"

        local opts = {
            theme = "doom",
            hide = {
                -- this is taken care of by lualine
                -- enabling this messes up the actual laststatus setting after loading a file
                statusline = false,
            },
            config = {
                header = vim.split(logo, "\n"),
                -- stylua: ignore
                center = {
                    { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
                    { action = "G",                                 desc = " Git Fugitive",    icon = " ", key = "G" },
                    { action = "Neotree",                           desc = " NeoTree",         icon = "󰐅 ", key = "E" },
                    { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
                    { action = "Telescope oldfiles",                desc = " Recent files",    icon = "󰄉 ", key = "r" },
                    { action = "Telescope live_grep",               desc = " Find text",       icon = " ", key = "g" },
                    --        { action = "e $MYVIMRC",                        desc = " Config",          icon = " ", key = "c" },
                    { action = "Neotree $XDG_CONFIG_HOME/nvim/lua", desc = " Config",          icon = " ", key = "c" },
                    { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                    { action = "Telescope projects",                desc = " Projects",        icon = " ", key = "p" },
                    { action = "LazyExtras",                        desc = " Lazy Extras",     icon = " ", key = "e" },
                    { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
                    { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                end,
            },
        }

        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        end

        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "DashboardLoaded",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        return opts
    end,
}

