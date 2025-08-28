return {
  "fxn/vim-monochrome",
  name = "monochrome",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "monochrome" then
      vim.cmd.colorscheme "monochrome"
    end
  end,
}


