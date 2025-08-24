return {
  "neanias/everforest-nvim",
  name = "everforest",
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "hard", -- hard | medium | soft
      italics = false,
      transparent_background_level = 0,
      sign_column_background = "none",
      ui_contrast = "high",
    })

    if vim.g.colorscheme == "everforest" then
      vim.cmd.colorscheme "everforest"
    end
  end,
}


