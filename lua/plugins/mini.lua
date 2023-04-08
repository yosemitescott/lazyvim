return {
  { "echasnovski/mini.comment",   enabled = false },
  { "echasnovski/mini.align",     config  = function(_, opts) require("mini.align").    setup(opts) end, },
  { "echasnovski/mini.bracketed", config  = function(_, opts) require("mini.bracketed").setup(opts) end, },
  --  {"echasnovski/mini.nvim", version = false },
}
