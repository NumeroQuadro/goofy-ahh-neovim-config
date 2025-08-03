return {
    {
        'rlane/pounce.nvim',
        config = function()
            require('pounce').setup({
                accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
                accept_best_key = "<enter>",
                multi_window = true,
                debug = false,
            })

            -- Key mappings
            vim.keymap.set("n", "s", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("n", "S", "<cmd>Pounce<CR>", { desc = "Pounce (visual)" })
            vim.keymap.set("o", "s", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("o", "S", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("i", "<c-s>", "<cmd>Pounce<CR>", { desc = "Pounce" })
        end
    }
} 