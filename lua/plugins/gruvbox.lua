return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  confsssig = function()
    if vim.g.colorscheme == "gruvbox" then
      vim.cmd.colorscheme "gruvbox"
    end
  end,
}
