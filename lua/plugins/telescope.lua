if true then return {} end

return {
    "nvim-telescope/telescope.nvim",
    enable = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = 'make'},
        "nvim-telescope/telescope-live-grep-args.nvim",
        "molecule-man/telescope-menufacture",
        "tsakirist/telescope-lazy.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("menufacture")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("noice")
            --    require("telescope").load_extension("live_grep_args")
        end,
    },
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
            file_ignore_patterns = {
                "tags",
            },
        },
    },
    keys = {
        -- add a keymap to browse plugin files
        -- stylua: ignore
        {
            "<leader>vv",
            "<cmd>lua require('telescope').extensions.menufacture.live_grep() type_filter=verilog<CR>",
            desc = "Live Grep - verilog - ctrl-6 to change",
        },
--      {
--          "<leader>fP",
--          function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--          desc = "Find Plugin File",
--      },
--      {
--          "<leader>sf",
--          function() require("telescope.builtin").find_files({'fd', vim.fn.expand("<cword>")}) end,
--          desc = "Search File under cursor",
--      },
--      {
--          "<leader>sf",
--          function() require("telescope.builtin").find_files({find_command={'fd', vim.fn.expand("<cword>")}}) end,
--          desc = "Search File under cursor",
--      },
--      {
--          "<leader>fl",
--          "<cmd>Telescope lazy<CR>",
--          desc = "Find Lazy Plugins",
--      },
--      {
--          "<leader>fg",
--          "<cmd>Telescope live_grep<CR>",
--          desc = "Live Grep",
--      },
--      {
--          "<leader>sl",
--          "<cmd>Telescope lsp_document_symbols<CR>",
--          desc = "Telescope LSP Symbols",
--      },
--      {
--          "<leader>sn",
--          "<cmd>Telescope noice<CR>",
--          desc = "Search Noice messages",
--      },
--      {
--          "<leader>gb",
--          "<cmd>Telescope git_branches<CR>",
--          desc = "Telescope Git Branches",
--      },
--      {
--          "<leader>8",
--          "<cmd>Telescope grep_string<CR>",
--          --"<cmd>lua require('telescope').extensions.menufacture.grep_string()<CR>",
--          desc = "Grep Word Under Cursor - ctrl-6 to change",
--      },
--      --  {
--      --    "<leader>fz",
--      --    "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
--      --    desc = "Live Grep Args",
--      --  },
--      {
--          "<leader>fx",
--          "<cmd>lua require('telescope').extensions.menufacture.find_files()<CR>",
--          desc = "Find Files - ctrl-6 to change",
--      },
--      {
--          "<leader>fy",
--          "<cmd>lua require('telescope').extensions.menufacture.git_files()<CR>",
--          desc = "Git Files - ctrl-6 to change",
--      },
--      {
--          "<leader>fz",
--          "<cmd>lua require('telescope').extensions.menufacture.live_grep()<CR>",
--          desc = "Live Grep - ctrl-6 to change",
--      },
--      {
--          "<leader>fu",
--          "<cmd>lua require('telescope').extensions.menufacture.oldfiles()<CR>",
--          desc = "Old Files - ctrl-6 to change",
--      },
    },






--  {
--      "nvim-telescope/telescope-ui-select.nvim",
--      config = function()
--          require("telescope").setup {
--              extensions = {
--                  ["ui-select"] = {
--                      require("telescope.themes").get_dropdown {
--                          -- even more opts
--                      }
--
--                      -- pseudo code / specification for writing custom displays, like the one
--                      -- for "codeactions"
--                      -- specific_opts = {
--                      --   [kind] = {
--                      --     make_indexed = function(items) -> indexed_items, width,
--                      --     make_displayer = function(widths) -> displayer
--                      --     make_display = function(displayer) -> function(e)
--                      --     make_ordinal = function(e) -> string
--                      --   },
--                      --   -- for example to disable the custom builtin "codeactions" display
--                      --      do the following
--                      --   codeactions = false,
--                      -- }
--                  },
--              },
--          }
--      end,
--  },
}
