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
                    "kotlin_language_server",
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

            -- Deduplicate LSP locations by uri + start position
            local function dedupe_locations(locations)
                if not locations or vim.tbl_isempty(locations) then return {} end
                local seen = {}
                local unique = {}
                for _, loc in ipairs(locations) do
                    local uri = loc.uri or loc.targetUri or ""
                    local range = loc.range or loc.targetSelectionRange or loc.targetRange or { start = { line = -1, character = -1 } }
                    local s = range.start or { line = -1, character = -1 }
                    local key = string.format("%s:%d:%d", uri, s.line or -1, s.character or -1)
                    if not seen[key] then
                        seen[key] = true
                        table.insert(unique, loc)
                    end
                end
                return unique
            end

            -- Present a list of locations in Telescope without re-requesting the LSP
            local function present_locations_with_telescope(locations, title)
                local ok, pickers = pcall(require, 'telescope.pickers')
                if not ok then
                    vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(locations, 'utf-8'))
                    vim.cmd('copen')
                    return
                end
                local finders = require('telescope.finders')
                local conf = require('telescope.config').values
                local make_entry = require('telescope.make_entry')
                local items = vim.lsp.util.locations_to_items(locations, 'utf-8')
                pickers.new({}, {
                    prompt_title = title or 'LSP Results',
                    finder = finders.new_table({
                        results = items,
                        entry_maker = make_entry.gen_from_quickfix(),
                    }),
                    sorter = conf.generic_sorter({}),
                    previewer = conf.qflist_previewer({}),
                }):find()
            end

            -- Compatibility helper for opening LSP locations without using deprecated APIs
            local function open_lsp_location(location)
                local util = vim.lsp.util
                if util and util.show_document then
                    if location.targetUri then
                        util.show_document({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
                    else
                        util.show_document(location, "utf-8")
                    end
                else
                    -- Fallback for older Neovim versions
                    if location.targetUri then
                        util.jump_to_location({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
                    else
                        util.jump_to_location(location, "utf-8")
                    end
                end
            end

            local function jump_to_first_location_or_picker(result, picker_name)
                if not result or vim.tbl_isempty(result) then return false end
                local locations = result
                -- Some servers return a table with a single element being the result
                if result.result then locations = result.result end
                if not locations or vim.tbl_isempty(locations) then return false end
                locations = dedupe_locations(locations)
                if #locations == 1 then
                    local loc = locations[1]
                    open_lsp_location(loc)
                else
                    -- Multiple results: show Telescope picker using these exact (deduped) locations
                    present_locations_with_telescope(locations, 'LSP ' .. (picker_name or 'Results'))
                end
                return true
            end

            local function goto_definition_smart()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, def)
                    if jump_to_first_location_or_picker(def, 'lsp_definitions') then return end
                    -- Fallback to type definition (common for Go struct/iface types)
                    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(_, tdef)
                        if jump_to_first_location_or_picker(tdef, 'lsp_type_definitions') then return end
                        -- Last resort: declaration
                        vim.lsp.buf.declaration()
                    end)
                end)
            end

            -- Note: use buffer-local mappings in on_attach; avoid global expr mappings to prevent timeouts

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                local buf_set_keymap = function(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end
                if client:supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                if client:supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                end

                local builtin = require('telescope.builtin')
                buf_set_keymap('n', 'gd', goto_definition_smart, { desc = 'LSP Definition (smart)' })
                buf_set_keymap('n', 'gT', function()
                    local params = vim.lsp.util.make_position_params()
                    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(_, tdef)
                        local ok = jump_to_first_location_or_picker(tdef, 'Type Definitions')
                        if not ok then return end
                    end)
                end, { desc = 'LSP Type Definition (deduped)' })
                buf_set_keymap('n', 'gi', builtin.lsp_implementations, { desc = 'LSP Implementation (Telescope)' })
                buf_set_keymap('n', 'gr', builtin.lsp_references, { desc = 'LSP References (Telescope)' })
                buf_set_keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
                buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
                buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
                buf_set_keymap('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
                buf_set_keymap('n', 'K', vim.lsp.buf.hover, { desc = "Hover" })
                buf_set_keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                buf_set_keymap('n', '<leader>e', function()
                    local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
                    if diags and #diags > 0 then
                        vim.diagnostic.open_float(nil, { scope = 'line', focus = false })
                        return
                    end
                    local ok, builtin = pcall(require, 'telescope.builtin')
                    if ok then
                        builtin.diagnostics({ bufnr = 0, prompt_title = 'Current File Diagnostics' })
                    else
                        vim.diagnostic.setloclist({ open = true })
                    end
                end, { desc = "Diagnostics: float/peek", nowait = true })
            end

            -- Setup LSP servers that benefit from default capabilities/on_attach
            -- Kotlin
            if lspconfig.kotlin_language_server then
                lspconfig.kotlin_language_server.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        kotlin = {
                            compiler = {
                                jvm = {
                                    target = "17",
                                },
                            },
                        },
                    },
                })
            end

            -- Java (Eclipse JDT Language Server)
            if lspconfig.jdtls then
                lspconfig.jdtls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    root_dir = lspconfig.util.root_pattern("gradlew", "mvnw", ".git"),
                    single_file_support = true,
                })
            end

            -- Go (gopls)
            if lspconfig.gopls then
                lspconfig.gopls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
                    settings = {
                        gopls = {
                            usePlaceholders = true,
                            analyses = { unusedparams = true, shadow = true },
                            codelenses = { test = true, tidy = true, upgrade_dependency = true },
                            hints = {
                                assignVariableTypes = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                })
            end

        end,
    }
}
