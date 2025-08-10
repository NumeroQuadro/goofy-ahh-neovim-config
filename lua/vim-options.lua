vim.g.colorscheme = "gruvbox" -- default theme
vim.g.gruvbox_bg_color = "#101010" -- default: slightly grey background for gruvbox

vim.cmd("set ignorecase")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.hidden = true
vim.g.mapleader = " "
vim.cmd("set wrap")
vim.cmd("set linespace=2")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to first non-whitespace character" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })

vim.o.mouse = ""



-- Auto-reload files changed outside of Neovim
vim.opt.autoread = true
vim.opt.confirm = true -- prompt before losing changes when reloading

local auto_read_group = vim.api.nvim_create_augroup("auto-read", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = auto_read_group,
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = auto_read_group,
  callback = function(args)
    vim.notify("File changed on disk. Buffer reloaded: " .. (args.file or ""), vim.log.levels.INFO)
  end,
})

-- Manual reload shortcut
vim.keymap.set("n", "<leader>R", "<cmd>checktime<CR>", { desc = "Reload files changed on disk" })

-- Keymap to switch themes
vim.keymap.set("n", "<leader>th", function()
  local themes = { "gruvbox", "black", "catppuccin", "oxocarbon" }
  vim.ui.select(themes, { prompt = "Select a theme" }, function(choice)
    if not choice then return end
    -- Set the global selector so theme plugin loaders can respect it
    vim.g.colorscheme = choice
    vim.cmd.colorscheme(choice)
  end)
end, { desc = "Switch theme" })

-- Quick Gruvbox background shade picker
vim.keymap.set("n", "<leader>gb", function()
  local shades = {
    "#000000", -- pure black
    "#0a0a0a",
    "#101010",
    "#121212",
    "#151515",
    "#1a1a1a",
    "#1e1e1e",
    "#222222",
  }
  vim.ui.select(shades, { prompt = "Gruvbox Normal bg" }, function(choice)
    if not choice then return end
    vim.g.gruvbox_bg_color = choice
    if vim.g.colorscheme == "gruvbox" then
      -- Re-apply to force highlight update
      vim.cmd("colorscheme gruvbox")
    end
  end)
end, { desc = "Gruvbox background shade" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s", "<cmd>split<CR>", { desc = "Split window horizontally" })

-- Buffer navigation and management
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Delete buffer (keep window)" })
vim.keymap.set("n", "<leader>ba", function()
  -- Delete all listed buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      pcall(vim.cmd, "Bdelete " .. buf)
    end
  end
end, { desc = "Delete all buffers" })
vim.keymap.set("n", "<leader>bo", function()
  -- Delete all other listed buffers
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      pcall(vim.cmd, "Bdelete " .. buf)
    end
  end
end, { desc = "Delete other buffers" })

-- Tab management (treat tabs as workspaces)
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tab split<CR>", { desc = "Move buffer to new tab" })

-- Hide Neo-tree buffer from buffer list (so it won't show in tabline buffers)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "neo-tree" },
  callback = function(args)
    if args.buf and vim.api.nvim_buf_is_valid(args.buf) then
      vim.bo[args.buf].buflisted = false
    end
  end,
})

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

-- Format SQL files on save using conform.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.sql",
  callback = function()
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = false })
    end
  end,
})

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
