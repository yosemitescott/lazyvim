if true then return {} end

return {
    "rmagatti/auto-session",
    keys = {
        { "<leader>fs", 
            function() require"auto-session.session-lens".search_session() end,
            desc = "Find Sessions" }
    },
    config = function()
        require("auto-session").setup{
            log_level                        = vim.log.levels.ERROR,
            auto_session_suppress_dirs       = { "~/", "~/Projects", "~/Downloads", "/" },
--          auto_session_use_git_branch      = false,
--          auto_session_enable_last_session = false,
            session_lens = {
                -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            }
    }
    end,
}
