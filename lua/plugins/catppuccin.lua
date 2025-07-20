return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "catppuccin" then
      vim.cmd.colorscheme "catppuccin"
    end
  end,
}
