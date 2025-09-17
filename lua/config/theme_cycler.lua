local function theme_cycler(step)
    MyThemeState  = 0
    local themes = {
        "neofusion",
        "gruvbox",
        "everforest",
        "miasma",
        "rose-pine",
        "PaperColor",
        "zenbones",
        "zenwritten",
        "neobones",
--      "vimbones",
        "rosebones",
        "forestbones",
        "nordbones",
        "tokyobones",
        "seoulbones",
        "duckbones",
        "zenburned",
        "kanagawabones",
--      "randombones",
        "moonfly",
        "nightfly",
        "nightfox",
        "carbonfox",
        "nordfox",
        "duskfox",
        "terafox",
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

vim.keymap.set("n", "<F7>", theme_cycler(0))
vim.keymap.set("n", "<F8>", theme_cycler(1))
