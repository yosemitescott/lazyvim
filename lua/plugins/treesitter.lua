return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "tree-sitter/tree-sitter-verilog",
    },

    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
          "verilog",
      })
    end,
}
