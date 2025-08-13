return {
  "ya2s/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = false,  -- Use native cursorline to avoid blink
        timeout = 0,
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