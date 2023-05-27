if true then return {} end

return {
    "lvim-tech/lvim-fm",
    dependencies = {
        "lvim-tech/lvim-shell",
    },

    config = function()
        require("lvim-fm").setup({
        })
    end,
}
