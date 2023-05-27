return {
    "neovim/nvim-lspconfig",
    init = function()
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
