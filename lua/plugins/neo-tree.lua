return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true, -- don't leave Neo-tree as the only window in a tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            window = {
                position = "left",
                width = 32,
                mappings = {
                    ["<space>"] = "none",
                },
            },
            filesystem = {
                bind_to_cwd = true,
                follow_current_file = { enabled = true },
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        })
        -- Always open Neo-tree in the current tab (sidebar), not as a separate tab/buffer focus
        vim.keymap.set('n', '<C-n>', function()
            vim.cmd('Neotree filesystem reveal left toggle')
        end, { desc = "Toggle Neo-tree file explorer" })
    end,
    opts = {
      -- fill any relevant options here
    },
}
