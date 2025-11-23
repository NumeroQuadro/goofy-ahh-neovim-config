return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            -- Default off for performance; enable on demand via toggle
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
        })
        -- One-off blame for the current line
        vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "git blame line (one-off)" })
        -- Toggle virtual current line blame on/off
        vim.keymap.set("n", "<leader>gB", function()
          require('gitsigns').toggle_current_line_blame()
        end, { desc = "git toggle current line blame" })
        vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "git reset hunk" })
    end,
}
