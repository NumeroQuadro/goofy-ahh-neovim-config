return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<C-p>', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup ({
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
              },
              pickers = {
                find_files = {
                  find_command = { "rg", "--files", "--hidden", "--no-ignore" },
                },
              },
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                  }
                }
              }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}
