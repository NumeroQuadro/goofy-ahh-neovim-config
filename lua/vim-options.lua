vim.cmd("set ignorecase")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.cmd("set wrap")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

