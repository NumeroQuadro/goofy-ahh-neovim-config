return {
  "nyoom-engineering/oxocarbon.nvim",
  name = "oxocarbon",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "oxocarbon" then
      vim.cmd.colorscheme "oxocarbon"
    end
  end,
}
