local function theme_cycler(step)
    MyThemeState  = 0
    local themes = {
        "nightfox",
        "carbonfox",
        "nordfox",
        "duskfox",
        "terafox",
        "gruvbox",
        "everforest",
        "PaperColor",
        "catppuccin-mocha",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin",
        "tokyonight-moon",
        "tokyonight-night",
        "tokyonight-storm",
        "kanagawa",
        "kanagawa-wave",
        "kanagawa-dragon",
        "kanagawa-lotus",
        "onedark",
        "onenord",
        "nord",
        "darkplus",
        "github_dark",
        "github_dark_colorblind",
        "github_dark_default",
        "github_dark_dimmed",
        "github_dark_high_contrast",
        "github_dark_tritanopia",
        "github_dimmed",
        "miasma",
        "rose-pine",
    }
    return function ()
        if (step == 1) then
            MyThemeState = (MyThemeState + 1) % #themes
        else
            MyThemeState = (MyThemeState - 1) % #themes
        end
        local theme = themes[MyThemeState + 1]
        vim.cmd.colorscheme(theme)
        print(theme)
    end
end

vim.keymap.set("n", "#7", theme_cycler(0))
vim.keymap.set("n", "#8", theme_cycler(1))
