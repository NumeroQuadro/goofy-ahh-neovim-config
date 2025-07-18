return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
        })
        vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "git blame line" })
        vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "git reset hunk" })
    end,
}
