if true then return {} end
return {
    "neovim/nvim-lspconfig",
    init = function()
--      require("lspconfig").svlangserver.setup({
--          on_attach = function(client)
--              client.server_capabilities.completionProvider = false
--          end,
--          --  on_attach = on_attach,
--          --  capabilities = capabilities,
--          filetypes = { "verilog", "systemverilog", "verilog_systemverilog" },
--          on_init = function(client)
--              local path = client.workspace_folders[1].name
--
--              if path == '/project/sfollmer/dcu' then
--                  client.config.settings.systemverilog = {
--                      includeIndexing     = {"**/*.{sv,svh}"},
--                      excludeIndexing     = {"test/**/*.sv*"},
--                      defines             = {},
--                      launchConfiguration = "$HOME/bin/install/verilator/bin/verilator -sv -Wall --lint-only",
--                      formatCommand       = "$HOME/bin/install/verible_verilog_format"
--                  }
--              elseif path == '/path/to/project2' then
--                  client.config.settings.systemverilog = {
--                      includeIndexing     = {"**/*.{sv,svh}"},
--                      excludeIndexing     = {"sim/**/*.sv*"},
--                      defines             = {},
--                      launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
--                      formatCommand       = "/tools/verible-verilog-format"
--                  }
--              end
--
--              client.notify("workspace/didChangeConfiguration")
--              return true
--          end
--
--      })

        require("lspconfig").svls.setup({
            on_attach = function(client)
                client.server_capabilities.completionProvider = false
            end,
            --  on_attach = on_attach,
            --  capabilities = capabilities,
            filetypes = { "verilog", "systemverilog", "verilog_systemverilog" },
            cmd = { "svls", "-d" },
        })
--      require("lazyvim.util").on_attach(function(_, buffer)
--          -- stylua: ignore
--      end)
    end,
    --  opts = function(_, opts)
    --  end,
}
