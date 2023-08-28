local M = {
    "sainnhe/everforest",
}

function M.config()                 -- Use config since it's not a LUA plugin
    vim.g.everforest_dim_inactive_windows = 1
    vim.g.everforest_better_performance   = 1
    vim.g.everforest_enable_italic        = 1
    vim.g.everforest_background           = 'hard'
end

return M

