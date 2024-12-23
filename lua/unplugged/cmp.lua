if true then return {} end

local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
    },
    -- @param opts cmp.ConfigSchema
}

function M.config()
    local cmp      = require("cmp")
    local nvim_lua = require("luasnip")

  --   פּ ﯟ   some other good icons
  local kind_icons = {
        Text          = "",
        Method        = "m",
        Function      = "",
        Constructor   = "",
        Field         = "",
        Variable      = "",
        Class         = "",
        Interface     = "",
        Module        = "",
        Property      = "",
        Unit          = "",
        Value         = "",
        Enum          = "",
        Keyword       = "",
        Snippet       = "",
        Color         = "",
        File          = "",
        Reference     = "",
        Folder        = "",
        EnumMember    = "",
        Constant      = "",
        Struct        = "",
        Event         = "",
        Operator      = "",
        TypeParameter = "",
  }

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        mapping = cmp.mapping.preset.insert({
    --      ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    --      ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    --      ["<C-p>"]     = cmp.mapping.select_prev_item(),
    --      ["<C-n>"]     = cmp.mapping.select_next_item(),
            ["<C-k>"]     = cmp.mapping.select_prev_item(),
            ["<C-j>"]     = cmp.mapping.select_next_item(),
            ["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"]     = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<C-e>"]     = cmp.mapping({
                                i = cmp.mapping.abort(),
                                c = cmp.mapping.close(),
                            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"]      = cmp.mapping.confirm({ select = false }),
            ["<c-i>"]     = cmp.mapping.confirm({
                                behavior = cmp.ConfirmBehavior.Insert,
                                select   = true,
                            }),
            ["<c-q>"]     = cmp.mapping.confirm({
                                behavior = cmp.ConfirmBehavior.Replace,
                                select   = true,
                            }),

      -- If you want tab completion :'(
      --  First you have to just promise to read `:help ins-completion`.
      --      ["<Tab>"] = cmp.mapping(function(fallback)
      --          if cmp.visible() then
      --              cmp.select_next_item()
      --          elseif luasnip.expandable() then
      --              luasnip.expand()
      --          elseif luasnip.expand_or_jumpable() then
      --              luasnip.expand_or_jump()
      --          elseif check_backspace() then
      --              fallback()
      --          else
      --              fallback()
      --          end
      --      end, {
      --              "i",
      --              "s",
      --          }),
      --      ["<S-Tab>"] = cmp.mapping(function(fallback)
      --                      if cmp.visible() then
      --                              cmp.select_prev_item()
      --                      elseif luasnip.jumpable(-1) then
      --                              luasnip.jump(-1)
      --                      else
      --                              fallback()
      --                      end
      --              end, {
      --                      "i",
      --                      "s",
      --              }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        --              vim_item.kind = kind_icons[vim_item.kind]
        --              vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({nvim_lsp = "[LSP]",
                          nvim_lua = "[NVIMLUA]",
                          luasnip  = "[Snippet]",
                          buffer   = "[Buffer]",
                          path     = "[Path]",
                          emoji    = "[Emoji]",
                        })[entry.source.name]
        return vim_item
      end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer",
          keyword_length = 3,
          option = {
                    get_bufnrs = function()
                        local buf       = vim.api.nvim_get_current_buf()
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size > 1024 * 1024 then -- 1 Megabyte max
                            return {}
                        end
                        return vim.api.nvim_list_bufs()
                      end
                   },
--        option = {
--                    get_bufnrs = function()     -- Look in visable buffers
--                        local bufs = {}
--                        for _, win in ipairs(vim.api.nvim_list_wins()) do
--                            bufs[vim.api.nvim_win_get_buf(win)] = true
--                        end
--                        return vim.tbl_keys(bufs)
--                    end
--                },
        },
        { name = "path" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select   = false,
    },
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
  })

  --end,

  --opts = function(_, opts)
  --  local cmp = require("cmp")

  --  opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  --end,
end

return M
