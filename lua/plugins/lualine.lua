return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local function netrw_dir_component()
            if vim.bo.filetype == 'netrw' then
                local dir = vim.b.netrw_curdir or vim.fn.getcwd()
                return ' ' .. vim.fn.fnamemodify(dir, ':~')
            end
            return ''
        end

        require('lualine').setup({
            options = {
                theme = 'dracula'
            },
            sections = {
                lualine_c = {
                    netrw_dir_component,
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
