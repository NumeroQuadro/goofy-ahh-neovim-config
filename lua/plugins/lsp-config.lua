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
                    "pyright",
                    "clangd",
                    "html",
                    "cssls",
                    "yamlls",
                    "bashls",
                    "jdtls",
                    "vimls",
                    "jsonls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }
            )

            local lspconfig = require("lspconfig")

            local buf_set_keymap = function(bufnr, mode, lhs, rhs, opts)

                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            local on_attach = function(client, bufnr)
                if client:supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                if client:supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                end

                local builtin = require('telescope.builtin')
                buf_set_keymap(bufnr, 'n', 'gd', builtin.lsp_definitions, { desc = 'LSP Definition (Telescope)' })
                buf_set_keymap(bufnr, 'n', 'gi', builtin.lsp_implementations, { desc = 'LSP Implementation (Telescope)' })
                buf_set_keymap(bufnr, 'n', 'gr', builtin.lsp_references, { desc = 'LSP References (Telescope)' })
                buf_set_keymap(bufnr, 'i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
                buf_set_keymap(bufnr, 'n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
                buf_set_keymap(bufnr, 'n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                buf_set_keymap(bufnr, 'n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
                buf_set_keymap(bufnr, 'n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
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
                        },
                        codelenses = {
                            generate = true,
                        },
                    },
                },
            })
            lspconfig.sqlls.setup({
                on_attach = function(client, bufnr)
                    -- Disable diagnostics for SQL files
                    client.server_capabilities.diagnosticProvider = false
                    -- Optionally, you can also clear any diagnostics on attach
                    vim.diagnostic.disable(bufnr)
                    if on_attach then on_attach(client, bufnr) end
                end,
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
                filetypes = { "c", "cpp", "objc", "objcpp" },
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
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})         

            vim.diagnostic.config({
              virtual_text = {
                format = function(diagnostic)
                  return string.format("%s: %s", diagnostic.source, diagnostic.message)
                end,
              },
              float = {
                source = "always",
                wrap = true,
                border = "rounded",
              },
              update_in_insert = false,
              -- Use Neovim's default sign text (no custom round dots)
              signs = {
                numhl = {
                  [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                  [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                  [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                  [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                },
              },
            })

            

            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*.go",
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
                pattern = "*.go",
                callback = function()
                    vim.lsp.codelens.refresh()
                end
            })

        end,
    }
}
