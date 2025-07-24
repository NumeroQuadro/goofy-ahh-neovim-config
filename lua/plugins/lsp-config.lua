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
                    "jsonls",
                    "protols"
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

            local buf_set_keymap = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            local on_attach = function(client, bufnr)
                client.offset_encoding = "utf-16"
                if client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                if client.supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                end

                buf_set_keymap('n', 'gd', function()
                    require('telescope.builtin').lsp_definitions()
                end, "Go to definition")
                buf_set_keymap('i', '<C-k>', vim.lsp.buf.signature_help, "Signature help")
                buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")
                buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, "Code action")
                buf_set_keymap('n', 'gr', require('telescope.builtin').lsp_references, "Go to references")
                buf_set_keymap('n', 'gi', require('telescope.builtin').lsp_implementations, "Go to implementations")
                buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, "Previous diagnostic")
                buf_set_keymap('n', ']d', vim.diagnostic.goto_next, "Next diagnostic")
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

            lspconfig.protols.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
                end,
                filetypes = { "proto" },
                root_dir = lspconfig.util.root_pattern(".git", "go.mod", "package.json", "proto", "api"),
                -- If you have your proto files in a directory other than the root of your project,
                -- you need to tell protols where to find them.
                -- For example, if your proto files are in a directory called "proto",
                -- you can add the following to the setup:
                -- root_dir = lspconfig.util.root_pattern("proto"),
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>pc", function() require("peek").close() end, { desc = "Close peek" })
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})         

            vim.diagnostic.config({
              virtual_text = {
                format = function(diagnostic)
                  -- Prepend the source name to the diagnostic message
                  return string.format("%s: %s", diagnostic.source, diagnostic.message)
                end,
              },
              float = {
                source = "always",
                wrap = true,
                border = "rounded",
              },
              update_in_insert = true,
            })

            vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
              callback = function()
                vim.diagnostic.config({
                  virtual_text = false,
                  underline = true,
                  severity_sort = true,
                })
              end,
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
