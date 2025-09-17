-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.abbreviations")
require("config.theme_cycler")

require('config.utils').setup_cb_expansion()

vim.api.nvim_create_user_command("ShareConfig", function()
  require("config.utils").share_config()
  vim.cmd("CCShareBuffer")
end, {})

vim.api.nvim_create_user_command("GatherConfig", function()
  require("config.utils").share_config()
end, {})

vim.api.nvim_create_user_command("GatherSnippets", function()
  require("config.utils").share_snippets()
end, {})

vim.api.nvim_create_user_command("ShareWithCodeCompanion", function()
  require("config.utils").share_temp_file()
end, {})
