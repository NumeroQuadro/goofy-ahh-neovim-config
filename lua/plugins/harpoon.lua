return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon.setup({
            settings = {
                key = function()
                    local branch = nil
                    local pipe = io.popen("git branch --show-current")
                    if pipe then
                        branch = pipe:read("*l")
                        pipe:close()
                    end

                    if branch and branch ~= "" then
                        return branch
                    else
                        -- Fallback to current working directory if not in a git repo or detached HEAD
                        return vim.fn.getcwd()
                    end
                end,
            },
        })

        -- Harpoon 2 automatically handles project-specific lists.
        -- No extra setup is needed for that core feature.

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end, { desc = "Harpoon: Delete file from list" })
        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle quick menu" })

        -- Keymaps to jump to specific marks
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to mark 1" })
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to mark 2" })
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to mark 3" })
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to mark 4" })
    end,
}
