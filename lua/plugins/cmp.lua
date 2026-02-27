return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = (function()
                if vim.fn.executable("make") == 1 then
                    return "make install_jsregexp"
                end
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
            }),
            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 1,
            },
            -- Keep fuzzy/non-prefix matching enabled so partial method names still surface.
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp", keyword_length = 1, max_item_count = 200 },
                { name = "luasnip" },
            }, {
                { name = "buffer", keyword_length = 3 },
                { name = "path" },
            }),
        })
    end,
}
