return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    -- build = "cd app && yarn install",
    build = ":call mkdp#util#install()",
    keys = {
        { "<leader>um", '<Plug>MarkdownPreviewToggle<cr>',        desc = "Toggle Markdown Preview" },
    },
}
