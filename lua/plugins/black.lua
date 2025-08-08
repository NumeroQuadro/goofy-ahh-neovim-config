return {
  "alexanderbluhm/black.nvim",
  name = "black",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "black" then
      vim.cmd.colorscheme "black"
    end
  end,
}


