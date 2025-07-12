-- To switch configs, change the name of the string in the line below.
local active_config = "goofy_ahh_config"

-- Standard lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
vim.opt.rtp:prepend(lazypath)

-- Load the options for the active config
require("configs." .. active_config .. ".vim-options")

-- Setup lazy.nvim to load plugins from the active config
require("lazy").setup({
  spec = "configs." .. active_config .. ".plugins",
  change_detection = {
    notify = false,
  },
})
