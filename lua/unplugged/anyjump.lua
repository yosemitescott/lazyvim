if true then return {} end
local M = {
    'pechorin/any-jump.vim',
    ft   = {"verilog", "verilog_systemverilog", "systemverilog"},
    keys = {
        { "<leader>vj", "<cmd>AnyJump<CR>",            desc = "Jump Tag" },
        { "<leader>vJ", "<cmd>AnyJumpBack<CR>",        desc = "Jump Back" },
    },
    init = function()
        vim.g.any_jump_disable_default_keybindings = 1
    end,

}

return M

