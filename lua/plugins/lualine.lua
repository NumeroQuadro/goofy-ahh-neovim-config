return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula'
            },
            sections = {
                lualine_c = {
                    'filename',
                    {
                        'modified',
                        symbols = {modified = '+', readonly = '-'},
                    }
                }
            }
        })
    end
}
