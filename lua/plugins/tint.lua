if true then return {} end

return {
    "levouh/tint.nvim",
    config = function()
        require("tint").setup({
            tint = -75,
        })
    end,
}

