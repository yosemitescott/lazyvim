-- if true then return {} end
local wk = require("which-key")
wk.register({
    k = {
        name = "+Kiwi",
    },
}, { prefix = "<leader>", mode = "n" })


return {
    'serenevoid/kiwi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
--  config = true,
--  local kiwi = require('kiwi')
    keys = {
        { "<leader>kw", ':lua require("kiwi").open_wiki_index()<cr>',      desc = "Open Wiki Index" },
        { "<leader>kd", ':lua require("kiwi").open_diary_index()<cr>',     desc = "Open Diary Index" },
        { "<leader>kn", ':lua require("kiwi").open_diary_new()<cr>',       desc = "Open Diary New" },
        { "<leader>kx", ':lua require("kiwi").todo.toggle()<cr>',          desc = "TODO Toggle" },
    },
}
