-- Retro Terminal colorscheme loader
-- Uses a dummy github repo pattern to satisfy lazy.nvim
return {
  dir = vim.fn.stdpath("config") .. "/colors",  -- Local directory
  name = "retro-terminal",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "retro-terminal" then
      vim.cmd.colorscheme "retro-terminal"
    end
  end,
}
