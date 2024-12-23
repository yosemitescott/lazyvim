if true then return {} end

return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
    build        = ":Neorg sync-parsers",
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},  -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        }
    end,
}
--
--
--  opts = {
--      load = {
--          ["core.defaults"]  = {},  -- Loads default behaviour
--          ["core.concealer"] = {},  -- Adds pretty icons to your documents
--          ["core.dirman"]    = {    -- Manages Neorg workspaces
--              config = {
--                  workspaces = {
--                      notes = "~/notes",
--                  },
--              },
--          },
--      },
--  },
