return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-ui-select.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                    },
                    -- This is the key to jumping to the right line
                    jump_type = "exact",
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--no-ignore" },
                    },
                    live_grep = {
                        additional_args = function(opts)
                            return {
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
                        end,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })

            telescope.load_extension("ui-select")

            vim.keymap.set('n', '<C-p>', builtin.find_files, {})
            vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        end
    }
}
