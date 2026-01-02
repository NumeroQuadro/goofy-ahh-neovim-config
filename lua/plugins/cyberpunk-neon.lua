-- Cyberpunk-Neon loader (local colorscheme from ~/.config/nvim/colors/)
return {
  dir = vim.fn.stdpath("config"),
  name = "cyberpunk-neon-loader",
  lazy = false,
  priority = 1000,
  config = function()
    -- Apply custom overrides when cyberpunk-neon loads
    local augroup = vim.api.nvim_create_augroup("cyberpunk-neon-tweaks", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      pattern = "cyberpunk-neon",
      callback = function()
        -- Softer cursorline: subtle dark highlight instead of blinding magenta
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1a2e" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ea00d9", bold = true })

        -- Replace dark purple (#711c91) with a visible light lavender
        local lavender = "#c792ea"  -- easier on eyes, still purple-ish
        vim.api.nvim_set_hl(0, "Identifier", { fg = lavender, bold = true })
        vim.api.nvim_set_hl(0, "PreProc", { fg = lavender, bold = true })
        vim.api.nvim_set_hl(0, "Special", { fg = lavender })
      end,
    })

    if vim.g.colorscheme == "cyberpunk-neon" then
      vim.cmd.colorscheme "cyberpunk-neon"
    end
  end,
}
