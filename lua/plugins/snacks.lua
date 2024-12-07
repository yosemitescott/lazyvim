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
                    { icon = " ", key = "c", desc = "Config w/ Telescope", action  = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
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





--spf  return {
--spf      "nvimdev/dashboard-nvim",
--spf      event = "VimEnter",
--spf      opts = function()
--spf          local logo = [[
--spf           _______________________________________________________________________________________
--spf           |                                                                                     |
--spf           |    ███╗   ██╗███████╗██╗    ██╗     ██████╗ ██╗     ███████╗███╗   ██╗███╗   ██╗    |
--spf           |    ████╗  ██║██╔════╝██║    ██║    ██╔════╝ ██║     ██╔════╝████╗  ██║████╗  ██║    |
--spf           |    ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██║  ███╗██║     █████╗  ██╔██╗ ██║██╔██╗ ██║    |
--spf           |    ██║╚██╗██║██╔══╝  ██║███╗██║    ██║   ██║██║     ██╔══╝  ██║╚██╗██║██║╚██╗██║    |
--spf           |    ██║ ╚████║███████╗╚███╔███╔╝    ╚██████╔╝███████╗███████╗██║ ╚████║██║ ╚████║    |
--spf           |    ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝╚═╝  ╚═══╝    |
--spf           |     _______  ________         __         __  __         ___                         |
--spf           |    / __/ _ \/ ___/ _ | ___   / /____    / /_/ /  ___   / _ \___ ___ ______ _____    |
--spf           |   / _// ___/ (_ / __ |(_-<  / __/ _ \  / __/ _ \/ -_) / , _/ -_|_-</ __/ // / -_)   |
--spf           |  /_/ /_/   \___/_/ |_/___/  \__/\___/  \__/_//_/\__/ /_/|_|\__/___/\__/\_,_/\__/    |
--spf           |_____________________________________________________________________________________|
--spf      ]]
--spf  
--spf          logo = string.rep("\n", 8) .. logo .. "\n\n"
--spf  
--spf          local opts = {
--spf              theme = "doom",
--spf              hide = {
--spf                  -- this is taken care of by lualine
--spf                  -- enabling this messes up the actual laststatus setting after loading a file
--spf                  statusline = false,
--spf              },
--spf              config = {
--spf                  header = vim.split(logo, "\n"),
--spf                  -- stylua: ignore
--spf                  center = {
--spf                      { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
--spf                      { action = "G",                                 desc = " Git Fugitive",    icon = " ", key = "G" },
--spf                      { action = "Neotree",                           desc = " NeoTree",         icon = "󰐅 ", key = "E" },
--spf                      { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
--spf                      { action = "Telescope oldfiles",                desc = " Recent files",    icon = "󰄉 ", key = "r" },
--spf                      { action = "Telescope live_grep",               desc = " Find text",       icon = " ", key = "g" },
--spf                      --        { action = "e $MYVIMRC",                        desc = " Config",          icon = " ", key = "c" },
--spf                      { action = "Neotree $XDG_CONFIG_HOME/nvim/lua", desc = " Config",          icon = " ", key = "c" },
--spf                      { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
--spf                      { action = "Telescope projects",                desc = " Projects",        icon = " ", key = "p" },
--spf                      { action = "LazyExtras",                        desc = " Lazy Extras",     icon = " ", key = "e" },
--spf                      { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
--spf                      { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
--spf                  },
--spf                  footer = function()
--spf                      local stats = require("lazy").stats()
--spf                      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--spf                      return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
--spf                  end,
--spf              },
--spf          }
--spf  
--spf          for _, button in ipairs(opts.config.center) do
--spf              button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
--spf          end
--spf  
--spf          -- close Lazy and re-open when the dashboard is ready
--spf          if vim.o.filetype == "lazy" then
--spf              vim.cmd.close()
--spf              vim.api.nvim_create_autocmd("User", {
--spf                  pattern = "DashboardLoaded",
--spf                  callback = function()
--spf                      require("lazy").show()
--spf                  end,
--spf              })
--spf          end
--spf  
--spf          return opts
--spf      end,
--spf  }
--return {
--    "glepnir/dashboard-nvim",
--
--    opts = function(_, opts)
--
--        local logo = [[
--            _______________________________________________________________________________________
--            |                                                                                     |
--            |    ███╗   ██╗███████╗██╗    ██╗     ██████╗ ██╗     ███████╗███╗   ██╗███╗   ██╗    |
--            |    ████╗  ██║██╔════╝██║    ██║    ██╔════╝ ██║     ██╔════╝████╗  ██║████╗  ██║    |
--            |    ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██║  ███╗██║     █████╗  ██╔██╗ ██║██╔██╗ ██║    |
--            |    ██║╚██╗██║██╔══╝  ██║███╗██║    ██║   ██║██║     ██╔══╝  ██║╚██╗██║██║╚██╗██║    |
--            |    ██║ ╚████║███████╗╚███╔███╔╝    ╚██████╔╝███████╗███████╗██║ ╚████║██║ ╚████║    |
--            |    ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝╚═╝  ╚═══╝    |
--            |     _______  ________         __         __  __         ___                         |
--            |    / __/ _ \/ ___/ _ | ___   / /____    / /_/ /  ___   / _ \___ ___ ______ _____    |
--            |   / _// ___/ (_ / __ |(_-<  / __/ _ \  / __/ _ \/ -_) / , _/ -_|_-</ __/ // / -_)   |
--            |  /_/ /_/   \___/_/ |_/___/  \__/\___/  \__/_//_/\__/ /_/|_|\__/___/\__/\_,_/\__/    |
--            |_____________________________________________________________________________________|
--            ]],
--
--        opts = {
--            header = vim.split(logo, "\n"),
--        },
--    end,
--}
