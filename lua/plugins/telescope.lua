return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', "folke/todo-comments.nvim", "nvim-telescope/telescope-file-browser.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            -- Render file paths relative to project root (cwd) in pickers
            local function rel_path_display(_, path)
                -- :~:. → home as ~, and relative to cwd; trim leading ./ if present
                local p = vim.fn.fnamemodify(path, ":~:.")
                return (p:gsub('^%./', ''))
            end

            telescope.setup({
                defaults = {
                    previewer = true,
                    previewer = true,
                    sorting_strategy = 'ascending',
                    -- Show paths relative to cwd (project root)
                    path_display = rel_path_display,
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob", "!**/.git/**",
                    },
                    -- This is the key to jumping to the right line
                    jump_type = "exact",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,   -- always show preview, even on short windows
                        preview_height = 0.5, -- 50% of Telescope height for preview pane
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--no-ignore" },
                    },
                    live_grep = {
                        additional_args = function(opts)
                            return {
                                "--glob", "!**/.git/**",
                                -- General Exclusions
                                "--glob", "!*.log",
                                "--glob", "!*.tmp",
                                "--glob", "!*.bak",
                                "--glob", "!*.swp",
                                "--glob", "!*.swo",
                                "--glob", "!*.zip",
                                "--glob", "!*.tar.gz",
                                "--glob", "!*.rar",
                                "--glob", "!*.7z",
                                -- Binary / Build Artifacts
                                "--glob", "!*.pdf",
                                "--glob", "!*.png",
                                "--glob", "!*.jpg",
                                "--glob", "!*.jpeg",
                                "--glob", "!*.gif",
                                "--glob", "!*.svg",
                                "--glob", "!*.ico",
                                "--glob", "!*.pyc",
                                "--glob", "!*.o",
                                "--glob", "!*.so",
                                "--glob", "!*.dll",
                                "--glob", "!*.exe",
                                "--glob", "!*.class",
                                "--glob", "!*.jar",
                                -- Minified files
                                "--glob", "!*.min.js",
                                "--glob", "!*.min.css",
                                -- Go specific
                                "--glob", "!go.mod",
                                "--glob", "!go.sum",
                                "--glob", "!vendor/**",
                                "--glob", "!*.pb.go",
                                "--glob", "!*.pb.gw.go",
                                "--glob", "!*.pb.scratch.go",
                                "--glob", "!*.pb.sensitivity.go",
                                -- Node specific
                                "--glob", "!node_modules/**",
                                "--glob", "!package-lock.json",
                                "--glob", "!yarn.lock",
                                -- Other common build directories
                                "--glob", "!dist/**",
                                "--glob", "!build/**",
                                "--glob", "!target/**",
                                -- Lock files
                                "--glob", "!Pipfile.lock",
                                "--glob", "!composer.lock",
                                "--glob", "!cover.out",
                                "--glob", "!coverage.out",
                            }
                        end,
                    },
                    -- Ensure LSP pickers (gd, gi, gr) show the whole file path
                    lsp_references = {
                        previewer = true,
                        fname_width = 200,
                        path_display = rel_path_display,
                        show_line = true,
                    },
                    lsp_definitions = {
                        fname_width = 200,
                        path_display = rel_path_display,
                        show_line = true,
                    },
                    lsp_implementations = {
                        fname_width = 200,
                        path_display = rel_path_display,
                        show_line = true,
                    },
                },
                extensions = {
                    -- ["ui-select"] = {
                    --     require("telescope.themes").get_dropdown {}
                    -- }
                    file_browser = {
                        hijack_netrw = false,
                        grouped = true,
                        hidden = true,
                        mappings = {
                            ["i"] = {
                                ["<C-t>"] = actions.select_tab,
                            },
                            ["n"] = {
                                ["t"] = actions.select_tab,
                                ["<C-t>"] = actions.select_tab,
                            },
                        }
                    }
                }
            })

            -- telescope.load_extension("ui-select")
            telescope.load_extension("todo-comments")
            telescope.load_extension("file_browser")

            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
            -- Enhanced diagnostics viewing
            vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = "View all diagnostics" })
            vim.keymap.set('n', '<leader>de', function()
                builtin.diagnostics({
                    severity_limit = "Error",
                    prompt_title = "Errors Only"
                })
            end, { desc = "View errors only" })
            vim.keymap.set('n', '<leader>dw', function()
                builtin.diagnostics({
                    severity_limit = "Warning",
                    prompt_title = "Warnings and Errors"
                })
            end, { desc = "View warnings and errors" })
            vim.keymap.set('n', '<leader>df', function()
                builtin.diagnostics({
                    bufnr = 0,
                    prompt_title = "Current File Diagnostics"
                })
            end, { desc = "View current file diagnostics" })
            
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
            vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = "Git buffer commits" })
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
            vim.keymap.set('n', '<leader>ft', "<cmd>Telescope todo-comments<cr>", { desc = "Find todos" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })

            -- Floating file browser with preview at project root
            vim.keymap.set('n', '<leader>fe', function()
                require('telescope').extensions.file_browser.file_browser({
                    path = vim.loop.cwd(),
                    cwd = vim.loop.cwd(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = true,
                    initial_mode = "normal",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,
                        preview_height = 0.5,
                    },
                })
            end, { desc = "File browser (project root)" })

            -- Quickly open file browser at current buffer's directory
            vim.keymap.set('n', '-', function()
                local fb = require('telescope').extensions.file_browser
                local here = vim.fn.expand("%:p:h")
                fb.file_browser({
                    path = here,
                    cwd = here,
                    select_buffer = true,
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = true,
                    initial_mode = "normal",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,
                        preview_height = 0.5,
                    },
                })
            end, { desc = "File browser (current file dir)" })

            vim.keymap.set('n', '<leader>ff', function()
                builtin.live_grep({
                    additional_args = {
                        -- regex (default) search with filters
                        "--glob", "!**/.git/**",
                        "--glob", "!**/*_mock*",
                        "--glob", "!*.pb",
                        "--glob", "!*.pb.go",
                        "--glob", "!*.pb.scratch.go",
                        "--glob", "!*.pb.gw.go",
                        "--glob", "!*.pb.sensitivity.go",
                        "--glob", "!*.log",
                        "--glob", "!*.tmp",
                        "--glob", "!*.bak",
                        "--glob", "!*.swp",
                        "--glob", "!*.swo",
                        "--glob", "!*.min.js",
                        "--glob", "!*.min.css",
                        "--glob", "!*.lock",
                        "--glob", "!*.zip",
                        "--glob", "!*.tar.gz",
                        "--glob", "!*.rar",
                        "--glob", "!*.7z",
                        "--glob", "!*.pdf",
                        "--glob", "!*.png",
                        "--glob", "!*.jpg",
                        "--glob", "!*.jpeg",
                        "--glob", "!*.gif",
                        "--glob", "!*.svg",
                        "--glob", "!*.ico",
                        "--glob", "!*.pyc",
                        "--glob", "!*.o",
                        "--glob", "!*.so",
                        "--glob", "!*.dll",
                        "--glob", "!*.exe",
                        "--glob", "!*.class",
                        "--glob", "!*.jar"
                    }
                })
            end, { desc = "Live Grep (filtered)" })

            -- Literal (fixed-string) grep: special characters don't need escaping
            vim.keymap.set('n', '<leader>fF', function()
                builtin.live_grep({
                    prompt_title = "Literal Grep (-F)",
                    additional_args = {
                        "-F", -- treat the pattern as a literal string
                        "--glob", "!**/.git/**",
                        "--glob", "!**/*_mock*",
                        "--glob", "!*.pb",
                        "--glob", "!*.pb.go",
                        "--glob", "!*.pb.scratch.go",
                        "--glob", "!*.pb.gw.go",
                        "--glob", "!*.pb.sensitivity.go",
                        "--glob", "!*.log",
                        "--glob", "!*.tmp",
                        "--glob", "!*.bak",
                        "--glob", "!*.swp",
                        "--glob", "!*.swo",
                        "--glob", "!*.min.js",
                        "--glob", "!*.min.css",
                        "--glob", "!*.lock",
                        "--glob", "!*.zip",
                        "--glob", "!*.tar.gz",
                        "--glob", "!*.rar",
                        "--glob", "!*.7z",
                        "--glob", "!*.pdf",
                        "--glob", "!*.png",
                        "--glob", "!*.jpg",
                        "--glob", "!*.jpeg",
                        "--glob", "!*.gif",
                        "--glob", "!*.svg",
                        "--glob", "!*.ico",
                        "--glob", "!*.pyc",
                        "--glob", "!*.o",
                        "--glob", "!*.so",
                        "--glob", "!*.dll",
                        "--glob", "!*.exe",
                        "--glob", "!*.class",
                        "--glob", "!*.jar"
                    }
                })
            end, { desc = "Live Grep (literal, no regex)" })
        end
    }
}
