return {
  "nyoom-engineering/oxocarbon.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- Set the colorscheme
    vim.cmd.colorscheme "oxocarbon"
  end,
}
