-- Local colorscheme loader for files in ./colors
return {
  dir = vim.fn.stdpath("config") .. "/colors",  -- Local directory
  name = "local-colors",
  lazy = false,
  priority = 1000,
  config = function()
    local local_themes = {
      ["retro-terminal"] = true,
      ["cyber-amber"] = true,
      ["retro-1984"] = true,
    }

    if local_themes[vim.g.colorscheme] then
      vim.cmd.colorscheme(vim.g.colorscheme)
    end
  end,
}
