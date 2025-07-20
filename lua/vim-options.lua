vim.g.colorscheme = "gruvbox" -- Change "catppuccin" to your desired theme, e.g: oxocarbon

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

vim.o.mouse = "a"



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

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s", "<cmd>split<CR>", { desc = "Split window horizontally" })

vim.keymap.set("n", "<leader>ot", function()
    local file_dir = vim.fn.expand('%:p:h')
    -- If the buffer is not a file, or in a new buffer, use the current working directory
    if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
        file_dir = vim.fn.getcwd()
    end
    vim.cmd('split')
    vim.cmd('lcd ' .. vim.fn.fnameescape(file_dir))
    vim.cmd('term')
end, { desc = "Open terminal in file's directory" })


-- Custom terminal setup
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
        -- Map Esc to exit terminal mode
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, buffer = true })
    end,
})

local term_info = { buf = nil, job_id = nil }

function _G.toggle_terminal()
    if term_info.buf and vim.api.nvim_buf_is_loaded(term_info.buf) then
        local term_win_id = vim.fn.bufwinid(term_info.buf)
        if term_win_id ~= -1 then
            vim.api.nvim_win_hide(term_win_id)
        else
            vim.cmd.vnew()
            vim.api.nvim_win_set_buf(0, term_info.buf)
            vim.cmd.wincmd("J")
            vim.api.nvim_win_set_height(0, 5)
        end
    else
        vim.cmd.vnew()
        vim.cmd.term()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(0, 5)
        term_info.buf = vim.api.nvim_get_current_buf()
        term_info.job_id = vim.bo[term_info.buf].channel
        vim.api.nvim_create_autocmd('BufWipeout', {
            buffer = term_info.buf,
            once = true,
            callback = function()
                term_info.buf = nil
                term_info.job_id = nil
            end,
        })
    end
end

vim.keymap.set("n", "<leader>st", "<cmd>lua _G.toggle_terminal()<CR>", { desc = "Toggle terminal" })

vim.keymap.set("n", "<leader>mr", function()
    if term_info.job_id then
        vim.fn.chansend(term_info.job_id, "make run\r\n")
    else
        print("Terminal job not started. Use <leader>st to open terminal.")
    end
end, { desc = "Send 'make run' to terminal" })

vim.keymap.set("n", "<leader>gt", function()
    if term_info.job_id then
        vim.fn.chansend(term_info.job_id, "go test ./...\r\n")
    else
        print("Terminal job not started. Use <leader>st to open terminal.")
    end
end, { desc = "Send 'go test ./...' to terminal" })
