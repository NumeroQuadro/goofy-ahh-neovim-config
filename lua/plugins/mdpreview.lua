return {
  "mrjones2014/mdpreview.nvim",
  ft = { "markdown" },
  dependencies = {
    "norcalli/nvim-terminal.lua",
  },
  config = function()
    vim.g.mdpreview_auto_start = 1
    vim.g.mdpreview_position = "left"
  end,
}
