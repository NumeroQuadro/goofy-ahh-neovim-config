return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "lua_ls",
                    "gopls",
                    "sqlls",
                    "buf_ls",
                    "ts_ls",
                    "pyright",
                    "clangd",
                    "html",
                    "cssls",
                    "yamlls",
                    "bashls",
                    "jdtls",
                    "vimls",
                    "jsonls"
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            local on_attach = function(client, bufnr)
                local buf_set_keymap = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                buf_set_keymap('n', 'gd', vim.lsp.buf.definition, "Go to definition")
                buf_set_keymap('n', 'K', vim.lsp.buf.hover, "Hover documentation")
                buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")
                buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, "Code action")
                buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, "Previous diagnostic")
                buf_set_keymap('n', ']d', vim.diagnostic.goto_next, "Next diagnostic")
            end

            lspconfig.lua_ls.setup({})
            lspconfig.gopls.setup({
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true, shadow = true },
                        staticcheck = true,
                    },
                },
            })
            lspconfig.sqlls.setup({})
            lspconfig.buf_ls.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.jdtls.setup({})
            lspconfig.vimls.setup({})
            lspconfig.jsonls.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
            

            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*.go",
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })

        end,
    }
}
