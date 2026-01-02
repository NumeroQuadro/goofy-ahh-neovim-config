return {
  "akai54/2077.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Make CursorLine more visible after the colorscheme loads
    local augroup = vim.api.nvim_create_augroup("2077-cursorline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      pattern = "2077",
      callback = function()
        -- Strong full-line highlight with a visible background
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a3a" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00eaff", bold = true })

        -- Bright GitSigns for better visibility
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff9f" })          -- bright green
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffea00" })       -- bright yellow
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff2a6d" })       -- bright pink/red
        vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#ff9f00" }) -- orange
        vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ff2a6d" })
        vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#00eaff" })    -- cyan
      end,
    })

    if vim.g.colorscheme == "2077" then
      vim.cmd.colorscheme "2077"
    end
  end,
}
