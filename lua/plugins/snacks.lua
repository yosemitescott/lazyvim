local my_header = [[
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

local git_enabled = function()
  local obj = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }):wait()
  return obj.code == 0
end

return {
    "folke/snacks.nvim",
    opts = {
        scroll  = { enabled = false,},
        git     = { enabled = true, },
--      lazygit = { enabled = true, },
--      win     = { enabled = true, },
        dashboard = {
            width  = 90,
            preset = {
                header = my_header,
                keys = {
                    { icon = " ", key = "G", desc = "Git Fugitive",        action  = ":G"},
                    { icon = "󰐅 ", key = "E", desc = "NeoTree",             action  = ":Neotree"},
                    { icon = " ", key = "f", desc = "Find File",           action  = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File",            action  = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text",           action  = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files",        action  = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config w/ fzf",       action  = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "C", desc = "Config w/ NeoTree",   action  = ":Neotree dir=$XDG_CONFIG_HOME/nvim/lua" },
                    { icon = " ", key = "s", desc = "Restore Session",     section = "session" },
                    { icon = " ", key = "x", desc = "Lazy Extras",         action  = ":LazyExtras" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy",                action  = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit",                action  = ":qa" },
                },
            },

            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { pane    = 2,
                  section = 'terminal',
                  align   = 'center',
                  cmd     = 'cat ' .. vim.fn.stdpath('config') .. '/new_rocket.cat',
                  height  = 11,
                  width   = 72,
                  padding = 1,
                },

                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects",     section = "projects",     indent = 2, padding = 1 },
                function()
--                  local pathname = vim.fn.stdpath("config")
--                  print( "Path is " .. pathname)
                    local in_git = Snacks.git.get_root() ~= nil
                    local cmds = {
 --                     {
 --                         title = "Notifications",
 --                         cmd = "gh notify -s -a -n5",
 --                         icon = " ",
 --                         height = 5,
 --                         enabled = true,
 --                     },
 --                     {
 --                         title = "Open Issues",
 --                         cmd = "gh issue list -L 3",
 --                         icon = " ",
 --                         height = 7,
 --                     },
 --                     {
 --                         icon = " ",
 --                         title = "Open PRs",
 --                         cmd = "gh pr list -L 3",
 --                         height = 7,
 --                     },
                        {
--                          icon   = " ",
                            icon    = "",
                            title  = "Git Status",
                            cmd    = "git status --short --branch --renames -uno",
                            height = 10,
                        },
                    }
                    return vim.tbl_map(function(cmd)
                        return vim.tbl_extend("force", {
                            pane    = 2,
                            section = "terminal",
                            enabled = in_git,
                            padding = 1,
                            ttl     = 5 * 60,
                            indent  = 3,
                        }, cmd)
                    end, cmds)
                end,
                { section = "startup" },
            },
        },
    },
}

