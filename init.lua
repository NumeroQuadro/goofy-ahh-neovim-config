-- Bootstrap lazy.nvim, a modern plugin manager for Neovim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- If lazy.nvim is not installed, clone it from GitHub
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load core Neovim options and keymaps from a separate file
require("vim-options")

-- Configure lazy.nvim to load all plugins from the 'plugins' directory
require("lazy").setup({
  spec = "plugins",             -- Directory or module where plugin specs are defined
  change_detection = {
    notify = false,             -- Disable notifications when plugins are reloaded
  },
})
