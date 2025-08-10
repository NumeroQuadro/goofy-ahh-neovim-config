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
            },
            tabline = {
                -- Minimal, uncluttered buffer list on the left
                lualine_a = {
                    {
                        'buffers',
                        show_filename_only = true,
                        hide_filename_extension = false,
                        show_modified_status = true,
                        max_length = vim.o.columns * 2 / 3,
                        symbols = { modified = ' +', alternate_file = '' },
                    },
                },
                -- Optional small tab indicator on the right (treat tabs as workspaces)
                lualine_z = {
                    {
                        'tabs',
                        max_length = vim.o.columns / 3,
                    }
                }
            }
        })
    end
}
