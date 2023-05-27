return {
    "neovim/nvim-lspconfig",
    init = function()
        require("lspconfig").svlangserver.setup({})
--      require("lspconfig").svlangserver.setup({
--          on_attach = function(client)
--              client.server_capabilities.completionProvider = false
--          end,
--          --  on_attach = on_attach,
--          --  capabilities = capabilities,
--          filetypes = { "verilog", "systemverilog", "verilog_systemverilog" },
--          launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
--          formatCommand = "/tools/verible-verilog-format",

--          --  on_init = function(client)
--          --      local path = client.workspace_folders[1].name

--          --      if path == '/path/to/project1' then
--          --      client.config.settings.systemverilog = {
--          --          includeIndexing     = {"**/*.{sv,svh}"},
--          --          excludeIndexing     = {"test/**/*.sv*"},
--          --          defines             = {},
--          --          launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
--          --          formatCommand       = "/tools/verible-verilog-format"
--          --      }
--          --      elseif path == '/path/to/project2' then
--          --      client.config.settings.systemverilog = {
--          --          includeIndexing     = {"**/*.{sv,svh}"},
--          --          excludeIndexing     = {"sim/**/*.sv*"},
--          --          defines             = {},
--          --          launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
--          --          formatCommand       = "/tools/verible-verilog-format"
--          --      }
--          --      end

--          --      client.notify("workspace/didChangeConfiguration")
--          --      return true
--          --  end
--      })
--      require("lazyvim.util").on_attach(function(_, buffer)
--          -- stylua: ignore
--      end)
    end,
}
