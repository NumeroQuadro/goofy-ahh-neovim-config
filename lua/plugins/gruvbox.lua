return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Ensure our Normal highlight override is applied whenever Gruvbox is set
    local augroup = vim.api.nvim_create_augroup("gruvbox-normal-bg", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      pattern = "gruvbox",
      callback = function()
        local color = vim.g.gruvbox_bg_color or "#101010" -- slightly grey instead of pure black
        vim.cmd(("hi Normal guibg=%s ctermbg=NONE"):format(color))
      end,
    })

    if vim.g.colorscheme == "gruvbox" then
      vim.cmd.colorscheme "gruvbox"
    end
  end,
}
