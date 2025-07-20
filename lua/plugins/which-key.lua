return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            -- The default options are great, so we don't need to add anything here.
            -- which-key will automatically pick up your keymap descriptions.
        })
    end,
}
