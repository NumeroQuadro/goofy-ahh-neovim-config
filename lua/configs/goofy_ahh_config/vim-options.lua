vim.cmd("set ignorecase")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.cmd("set wrap")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to first non-whitespace character" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })

vim.o.mouse = ""



-- Keymap to switch themes
vim.keymap.set("n", "<leader>th", function()
  local themes = {
    "catppuccin",
    "oxocarbon",
  }
  vim.ui.select(themes, {
    prompt = "Select a theme",
  }, function(choice)
    if choice then
      vim.cmd.colorscheme(choice)
    end
  end)
end, { desc = "Switch theme" })

