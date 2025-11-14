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

-- Ensure common Homebrew paths are available for Neovim (e.g., im-select)
do
  local candidates = { "/opt/homebrew/bin", "/usr/local/bin" }
  for _, p in ipairs(candidates) do
    if vim.fn.isdirectory(p) == 1 and not string.find(vim.env.PATH or '', vim.pesc(p)) then
      vim.env.PATH = p .. ":" .. (vim.env.PATH or '')
    end
  end
end

-- Load core Neovim options and keymaps from a separate file
require("vim-options")

-- Configure lazy.nvim to load all plugins from the 'plugins' directory
require("lazy").setup({
  spec = "plugins",             -- Directory or module where plugin specs are defined
  change_detection = {
    notify = false,             -- Disable notifications when plugins are reloaded
  },
  -- Disable LuaRocks support to silence warnings (no plugins require it)
  rocks = { enabled = false },
})

-- Quiet noisy LSP popups from gopls (e.g., InlayHint metadata warnings)
pcall(require, "lsp-noise")

-- Core LSP bootstrap (uses vim.lsp.start, no lspconfig framework)
pcall(require, "lsp-core")
