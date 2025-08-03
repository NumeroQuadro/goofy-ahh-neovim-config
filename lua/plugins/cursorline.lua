return {
  "ya2s/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = false,  -- Disable cursorline highlighting
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,   -- Enable word underlining
        min_length = 3,
        hl = { underline = true },
      }
    }
  end
} 