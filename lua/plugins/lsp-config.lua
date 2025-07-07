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
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }
            )

            local lspconfig = require("lspconfig")

            local on_attach = function(client, bufnr)
                if client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
                local buf_set_keymap = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                buf_set_keymap('n', 'gd', vim.lsp.buf.definition, "Go to definition")
                buf_set_keymap('n', 'K', vim.lsp.buf.hover, "Hover documentation")
                buf_set_keymap('i', '<C-h>', vim.lsp.buf.signature_help, "Signature help")
                buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")
                buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, "Code action")
                buf_set_keymap('n', 'gr', vim.lsp.buf.references, "Go to references")
                buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, "Previous diagnostic")
                buf_set_keymap('n', ']d', vim.diagnostic.goto_next, "Next diagnostic")
                buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
            end

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
            })
            lspconfig.gopls.setup({
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true, shadow = true },
                        staticcheck = true,
                        hints = {
                            parameterNames = true,
                            assignVariableTypes = true,
                        }
                    },
                },
            })
            lspconfig.sqlls.setup({
                on_attach = on_attach,
            })
            lspconfig.buf_ls.setup({
                on_attach = on_attach,
            })
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
            })
            lspconfig.pyright.setup({
                on_attach = on_attach,
            })
            lspconfig.clangd.setup({
                on_attach = on_attach,
            })
            lspconfig.html.setup({
                on_attach = on_attach,
            })
            lspconfig.cssls.setup({
                on_attach = on_attach,
            })
            lspconfig.yamlls.setup({
                on_attach = on_attach,
            })
            lspconfig.bashls.setup({
                on_attach = on_attach,
            })
            lspconfig.jdtls.setup({
                on_attach = on_attach,
            })
            lspconfig.vimls.setup({
                on_attach = on_attach,
            })
            lspconfig.jsonls.setup({
                on_attach = on_attach,
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})         

            vim.diagnostic.config({
              float = {
                source = "always",
                wrap = true,
                border = "rounded",
              },
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*.go",
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })

        end,
    }
}
