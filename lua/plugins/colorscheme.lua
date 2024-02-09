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
    { "LazyVim/LazyVim", opts = {
--      colorscheme = "nightfox",
        colorscheme = "gruvbox",
    } },

}
