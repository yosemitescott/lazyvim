return {
    "lunarvim/darkplus.nvim",
    "NLKNguyen/papercolor-theme",
    "navarasu/onedark.nvim", -- Theme inspired by Atom
    --  'shaunsingh/nord.nvim',
    "gbprod/nord.nvim",
    "rmehri01/onenord.nvim",
    "projekt0n/github-nvim-theme",
    "xero/miasma.nvim",

--  "gruvbox-community/gruvbox",
    { "ellisonleao/gruvbox.nvim",
        opts = {
            contrast     = "hard",
            dim_inactive = true,
        },
    },

    { "sainnhe/everforest",
        config = function()
            vim.g.everforest_dim_inactive_windows = 1
            vim.g.everforest_better_performance   = 1
            vim.g.everforest_enable_italic        = 1
            vim.g.everforest_background           = 'hard'
        end,
    },

    { "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                dim_inactive = {
                    enabled = true, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
            })
        end,
    },

    { "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                dim_inactive = true,
            })
        end,
    },
    { "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                dimInactive = true,
            })
        end,
    },
    {"edeneast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
               options = {
                    dim_inactive = true,
                },
            })
        end,
    },
    {"bluz71/vim-moonfly-colors",
        name     = "moonfly",
        lazy     = false,
        priority = 1000,
    },
    {"bluz71/vim-nightfly-colors",
        name     = "nightfly",
        lazy     = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",

        config = function()
            require("rose-pine").setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = 'auto',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant             = 'main',
                bold_vert_split          = false,
                dim_nc_background        = true,
                disable_background       = false,
                disable_float_background = false,
                disable_italics          = false,
                dim_inactive             = true,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background    = 'base',
                    background_nc = '_experimental_nc',
                    panel         = 'surface',
                    panel_nc      = 'base',
                    border        = 'highlight_med',
                    comment       = 'muted',
                    link          = 'iris',
                    punctuation   = 'subtle',

                    error         = 'love',
                    hint          = 'iris',
                    info          = 'foam',
                    warn          = 'gold',

                    headings = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam',
                    }
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = {
                    ColorColumn = { bg = 'rose' },

                    -- Blend colours against the "base" background
                    CursorLine = { bg = 'foam', blend = 10 },
                    StatusLine = { fg = 'love', bg = 'love', blend = 10 },
                },
            })
        end,

    },
    { "diegoulloao/neofusion.nvim", priority = 1000 , config = true,
        opts = {
            dim_inactive = true,
        },
    },
    { "LazyVim/LazyVim", opts = {
--      colorscheme = "nightfox",
--      colorscheme = "gruvbox",
--      colorscheme = "everforest",
        colorscheme = "neofusion",
    } },

--  { "lukas-reineke/virt-column.nvim", opts = {} },

--  { "ecthelionvi/NeoColumn.nvim",
--      opts = {
--          NeoColumn = "139",
--      },
--  },

--  { "m4xshen/smartcolumn.nvim",
--      opts = {
--          colorcolumn = "139",
--      },
--
-- },

--  { "Bekaboo/deadcolumn.nvim",
--      opts = {
--          scope = 'line', ---@type string|fun(): integer
--          ---@type string[]|fun(mode: string): boolean
--          modes = function(mode)
--              return mode:find('^[nictRss\x13]') ~= nil
--          end,
--      },
--  },

}
