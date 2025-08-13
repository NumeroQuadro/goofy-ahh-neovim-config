return {
  "ya2s/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = true,  -- Enable cursorline highlighting for visibility
        timeout = 50,
        number = false,
      },
      cursorword = {
        enable = false,   -- Disable word underlining; only current line highlight remains
        min_length = 3,
        hl = { underline = true },
      }
    }
  end
} 