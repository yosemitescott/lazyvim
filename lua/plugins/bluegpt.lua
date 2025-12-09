-- if true then return {} end

--      return {
--      	"tdub0/gp.nvim",
--          config = true,
--      --  config = function()
--      --  	require("gp").setup()
--      --
--      --  	-- or setup with your own config (see Install > Configuration in Readme)
--      --  	-- require("gp").setup(config)
--      --      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
--      --  end,
--      }

return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            display = {
                chat = {
                    window = {
                        position = "right",
                        width = 0.25,
                    },
                },
            },
            adapters = {
                opts = {
                    show_defaults = false,
                },
                blue_openai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            -- This must be set as an environment variable
                            api_key = "AI_API_KEY",
                        },
                        url = "https://ai-service.blueorigin.com/api/v1/chat/completions",
                        schema = {
                            model = {
                                -- default = "gpt-4o",
--                              default = "anthropic.claude-3-5-sonnet-20240620-v1:0",
--                              default = "anthropic.claude-sonnet-4-5-20250929-v1:0",
                                default = "anthropic.claude-sonnet-4-20250514-v1:0",
                                -- default = "o3-mini",
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat   = { adapter = "blue_openai", },
                inline = { adapter = "blue_openai", },
                slash_commands = {
                    ["file"] = {
                        -- Location to the slash command in CodeCompanion
--                      callback = "strategies.chat.slash_commands.file",
--                      description = "Select a file using Telescope",
                        opts = {
                            provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                        },
                    },
                },
            },
            opts = {
                -- Set debug logging
                log_level = "DEBUG",
            },
        },
    },
}
