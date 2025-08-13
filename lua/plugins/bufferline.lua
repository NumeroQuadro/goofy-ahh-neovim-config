return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local ok, bufferline = pcall(require, "bufferline")
            if not ok then return end

            bufferline.setup({
                options = {
                    mode = "tabs",                    -- show Vim tabs (not buffers)
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    always_show_bufferline = true,
                    separator_style = "thin",         -- keep rectangle blocks
                    diagnostics = false,
                    themable = true,
                    tab_size = 18,
                    max_name_length = 22,
                },
            })
        end,
    },
}


