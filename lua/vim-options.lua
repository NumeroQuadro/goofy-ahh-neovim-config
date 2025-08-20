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
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.hidden = true
vim.g.mapleader = " "
vim.cmd("set wrap")
vim.cmd("set linespace=2")

-- Netrw sane defaults
vim.g.netrw_banner = 0            -- hide banner
vim.g.netrw_liststyle = 3         -- tree view
vim.g.netrw_keepdir = 1           -- keep :pwd stable when browsing

-- Helper: open netrw at a directory and place cursor on the current file (no extra highlighting)
local function open_netrw_dir(dir_path, opts)
  opts = opts or {}
  local previous_file = vim.fn.expand('%:p')
  -- Remember the previous buffer in this tab to return to it on cancel
  vim.t.netrw_prev_buf = vim.api.nvim_get_current_buf()
  if opts.sidebar then
    vim.cmd('topleft vsplit')
    vim.cmd('vertical resize 30')
    vim.cmd('edit ' .. vim.fn.fnameescape(dir_path))
  else
    vim.cmd('edit ' .. vim.fn.fnameescape(dir_path))
  end
  local current_name = vim.fn.fnamemodify(previous_file, ':t')
  if current_name == '' then return end
  pcall(vim.cmd, 'normal! gg')
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local target_line = nil
  for i, line in ipairs(lines) do
    if (#line >= #current_name and line:sub(-#current_name) == current_name)
      or (#line >= #current_name + 1 and line:sub(-(#current_name + 1)) == current_name .. '/') then
      target_line = i
      break
    end
  end
  if target_line then
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
  end
end

-- Find a reasonable project root by walking up from a start directory
local function find_project_root(start_dir)
  local dir = start_dir or vim.fn.expand('%:p:h')
  if dir == "" or vim.fn.isdirectory(dir) == 0 then
    dir = vim.fn.getcwd()
  end
  local markers = { '.git', '.hg', '.svn', 'package.json', 'go.mod', 'pyproject.toml', 'Cargo.toml', 'Makefile' }
  local previous = nil
  while dir ~= previous do
    for _, marker in ipairs(markers) do
      if vim.fn.isdirectory(dir .. '/' .. marker) == 1 or vim.fn.filereadable(dir .. '/' .. marker) == 1 then
        return dir
      end
    end
    previous = dir
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then break end
    dir = parent
  end
  return vim.fn.getcwd()
end

-- In netrw, allow canceling (keep tab open): 'q' or <Esc>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom-netrw-mappings", { clear = true }),
  pattern = "netrw",
  callback = function(args)
    local netrw_buf = args.buf
    -- Capture previous buffer for this netrw instance
    if vim.t.netrw_prev_buf and vim.api.nvim_buf_is_valid(vim.t.netrw_prev_buf) then
      vim.b.netrw_prev_buf = vim.t.netrw_prev_buf
    elseif vim.fn.bufnr('#') > 0 and vim.api.nvim_buf_is_valid(vim.fn.bufnr('#')) then
      vim.b.netrw_prev_buf = vim.fn.bufnr('#')
    end
    local function close_netrw()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1 then
        -- Multiple windows: only close the netrw window
        pcall(vim.api.nvim_win_close, 0, true)
        return
      end
      -- Single window: switch back to previous buffer if possible
      local prev = vim.b.netrw_prev_buf
      if prev and vim.api.nvim_buf_is_valid(prev) and prev ~= netrw_buf then
        pcall(vim.api.nvim_set_current_buf, prev)
      else
        local alt = vim.fn.bufnr('#')
        if alt > 0 and vim.api.nvim_buf_is_valid(alt) and alt ~= netrw_buf then
          pcall(vim.cmd, 'buffer #')
        else
          -- Fallback to any listed normal buffer
          local fallback = nil
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(b)
              and vim.bo[b].buflisted
              and vim.bo[b].buftype == ''
              and b ~= netrw_buf then
              fallback = b
              break
            end
          end
          if fallback then
            pcall(vim.api.nvim_set_current_buf, fallback)
          end
        end
      end
      if vim.api.nvim_buf_is_valid(netrw_buf) then
        pcall(vim.cmd, 'bdelete ' .. netrw_buf)
      end
    end
    vim.keymap.set("n", "q", close_netrw, { buffer = netrw_buf, nowait = true, silent = true, desc = "Quit netrw (cancel)" })
    vim.keymap.set("n", "<Esc>", close_netrw, { buffer = netrw_buf, nowait = true, silent = true, desc = "Quit netrw (cancel)" })
    
    -- File management shortcuts
    vim.keymap.set("n", "a", "%", { buffer = netrw_buf, nowait = true, silent = true, desc = "Create new file" })
    vim.keymap.set("n", "A", "d", { buffer = netrw_buf, nowait = true, silent = true, desc = "Create new directory" })
    vim.keymap.set("n", "r", "R", { buffer = netrw_buf, nowait = true, silent = true, desc = "Rename file/directory" })
    vim.keymap.set("n", "dd", "D", { buffer = netrw_buf, nowait = true, silent = true, desc = "Delete file/directory" })
    vim.keymap.set("n", "yy", function()
      -- Copy file - get filename under cursor and prompt for destination
      local filename = vim.fn.expand("<cfile>")
      if filename == "" then
        print("No file under cursor")
        return
      end
      local dest = vim.fn.input("Copy '" .. filename .. "' to: ", filename .. "_copy")
      if dest ~= "" then
        local cmd = "cp " .. vim.fn.shellescape(filename) .. " " .. vim.fn.shellescape(dest)
        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          print("Copied: " .. filename .. " -> " .. dest)
          vim.cmd("edit .") -- Refresh netrw
        else
          print("Copy failed: " .. result)
        end
      end
    end, { buffer = netrw_buf, nowait = true, silent = true, desc = "Copy file" })
    
    -- Additional helpful shortcuts
    vim.keymap.set("n", ".", function()
      vim.cmd("edit .") -- Refresh netrw view
    end, { buffer = netrw_buf, nowait = true, silent = true, desc = "Refresh view" })
    
    vim.keymap.set("n", "h", "-", { buffer = netrw_buf, nowait = true, silent = true, desc = "Go up directory" })
    vim.keymap.set("n", "l", "<CR>", { buffer = netrw_buf, nowait = true, silent = true, desc = "Enter directory/open file" })
  end,
})

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
-- Only trigger on focus/terminal events and avoid prompting when there are unsaved buffers
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = auto_read_group,
  callback = function()
    if #vim.fn.getbufinfo({ bufmodified = 1 }) == 0 then
      vim.cmd("checktime")
    end
  end,
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

-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
-- Switch tabs without leader
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>ts", "<cmd>tab split<CR>", { desc = "Open current buffer in new tab" })

-- Open native netrw at project root and place cursor on current file
vim.keymap.set("n", "<leader>fe", function()
  local start_dir = vim.fn.expand('%:p:h')
  local root = find_project_root(start_dir)
  open_netrw_dir(root, { sidebar = false })
end, { desc = "Explore project root" })

-- Open netrw as a left sidebar from current file's directory (manual split + edit)
vim.keymap.set("n", "<leader>le", function()
  local file_dir = vim.fn.expand('%:p:h')
  if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
    file_dir = vim.fn.getcwd()
  end
  open_netrw_dir(file_dir, { sidebar = true })
end, { desc = "Left Explore (sidebar)" })

-- Quick open Explore with '-' like many terminals (edit directory in place)
vim.keymap.set("n", "-", function()
  local file_dir = vim.fn.expand('%:p:h')
  if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
    file_dir = vim.fn.getcwd()
  end
  open_netrw_dir(file_dir, { sidebar = false })
end, { desc = "Explore current directory" })

-- Global file operations (work from anywhere)
vim.keymap.set("n", "<leader>nf", function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == "" or vim.fn.isdirectory(current_dir) == 0 then
    current_dir = vim.fn.getcwd()
  end
  local filename = vim.fn.input("New file name: ", current_dir .. "/")
  if filename ~= "" then
    vim.cmd("edit " .. vim.fn.fnameescape(filename))
  end
end, { desc = "Create new file" })

vim.keymap.set("n", "<leader>nd", function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == "" or vim.fn.isdirectory(current_dir) == 0 then
    current_dir = vim.fn.getcwd()
  end
  local dirname = vim.fn.input("New directory name: ", current_dir .. "/")
  if dirname ~= "" then
    vim.fn.mkdir(dirname, "p")
    print("Created directory: " .. dirname)
  end
end, { desc = "Create new directory" })

vim.keymap.set("n", "<leader>rf", function()
  local current_file = vim.fn.expand('%:p')
  if current_file == "" then
    print("No file to rename")
    return
  end
  local new_name = vim.fn.input("Rename file to: ", current_file)
  if new_name ~= "" and new_name ~= current_file then
    local success = vim.fn.rename(current_file, new_name)
    if success == 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(new_name))
      vim.cmd("bdelete #") -- Delete the old buffer
      print("Renamed: " .. vim.fn.fnamemodify(current_file, ':t') .. " -> " .. vim.fn.fnamemodify(new_name, ':t'))
    else
      print("Rename failed")
    end
  end
end, { desc = "Rename current file" })

vim.keymap.set("n", "<leader>df", function()
  local current_file = vim.fn.expand('%:p')
  if current_file == "" then
    print("No file to delete")
    return
  end
  local confirm = vim.fn.input("Delete '" .. vim.fn.fnamemodify(current_file, ':t') .. "'? (y/N): ")
  if confirm:lower() == "y" then
    local success = vim.fn.delete(current_file)
    if success == 0 then
      vim.cmd("bdelete!")
      print("Deleted: " .. vim.fn.fnamemodify(current_file, ':t'))
    else
      print("Delete failed")
    end
  end
end, { desc = "Delete current file" })

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

-- Tab keymaps removed to keep workflow buffer-centric for now

-- Hide Neo-tree buffer from buffer list (so it won't show in tabline buffers)
-- Neo-tree was removed; cleanup of related autocmds is no longer necessary

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
        -- Clear terminal screen + scrollback (similar to kitty Cmd+K)
        -- Note: Cmd+K is usually intercepted by the host terminal; use <C-k> inside Neovim terminal instead
        vim.keymap.set('t', '<C-k>', function()
            local job = vim.b.terminal_job_id
            if job then
                -- Clear screen then scrollback
                vim.fn.chansend(job, 'clear; printf "\\033[3J"\r')
            end
        end, { noremap = true, silent = true, buffer = true, desc = 'Clear terminal screen+scrollback' })
    end,
})

-- Auto-close terminal buffers when the job exits so :qa isn't blocked by dead terminals
vim.api.nvim_create_autocmd('TermClose', {
    group = vim.api.nvim_create_augroup('custom-term-close', { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype == 'terminal' then
            vim.schedule(function()
                pcall(vim.cmd, 'bdelete! ' .. args.buf)
            end)
        end
    end,
})

-- On quit, make sure all terminal buffers are wiped silently
vim.api.nvim_create_autocmd('QuitPre', {
    group = vim.api.nvim_create_augroup('custom-quit-cleanup', { clear = true }),
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'terminal' then
                pcall(vim.cmd, 'bdelete! ' .. buf)
            end
        end
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

-- Clear the managed toggle terminal from normal mode
vim.keymap.set("n", "<leader>sk", function()
    if term_info.job_id then
        vim.fn.chansend(term_info.job_id, 'clear; printf "\\033[3J"\r')
    else
        print("Terminal job not started. Use <leader>st to open terminal.")
    end
end, { desc = "Clear terminal screen+scrollback" })

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
