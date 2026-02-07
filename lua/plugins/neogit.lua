return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  init = function()
    local function resolve_git_root(start_dir)
      local candidates = {}
      local cwd = vim.fn.getcwd()
      if cwd and cwd ~= "" then
        table.insert(candidates, cwd)
      end
      if start_dir and start_dir ~= "" then
        table.insert(candidates, start_dir)
        if start_dir:match("/%.git$") then
          table.insert(candidates, vim.fn.fnamemodify(start_dir, ":h"))
        end
      end

      local seen = {}
      for _, dir in ipairs(candidates) do
        if dir ~= "" and not seen[dir] then
          seen[dir] = true
          local root_out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
          if vim.v.shell_error == 0 and root_out[1] then
            local root = vim.trim(root_out[1])
            if root ~= "" then
              return root
            end
          end
        end
      end

      return nil
    end

    local group = vim.api.nvim_create_augroup("custom-gitcommit-template", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "gitcommit",
      desc = "Prefill commit message with issue key from branch name",
      callback = function(args)
        local buf = args.buf
        local line_count = vim.api.nvim_buf_line_count(buf)
        local inspect_to = math.min(line_count, 80)
        local lines = vim.api.nvim_buf_get_lines(buf, 0, inspect_to, false)

        -- Do nothing if this buffer already contains a real commit message.
        for _, line in ipairs(lines) do
          if line:match("^%s*$") then
            -- ignore blanks
          elseif line:match("^%s*#") then
            -- ignore comment/help lines
          else
            return
          end
        end

        -- Avoid double insertion if the filetype autocmd runs more than once.
        local first_line = lines[1] or ""
        if first_line:match("^%[%[[A-Z][A-Z0-9]+%-%d+:%s*%]%]$") then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(buf)
        local start_dir = (bufname ~= "" and vim.fn.fnamemodify(bufname, ":p:h")) or vim.fn.getcwd()
        local git_root = resolve_git_root(start_dir)
        if not git_root then
          return
        end

        local branch_out = vim.fn.systemlist({ "git", "-C", git_root, "branch", "--show-current" })
        if vim.v.shell_error ~= 0 or not branch_out[1] then
          return
        end
        local branch = vim.trim(branch_out[1])
        if branch == "" then
          return
        end

        local issue_key = branch:match("(MYACC%-%d+)") or branch:match("([A-Z][A-Z0-9]+%-%d+)")
        if not issue_key then
          return
        end

        local template = string.format("[[%s: ]]", issue_key)
        if first_line:match("^%s*$") then
          vim.api.nvim_buf_set_lines(buf, 0, 1, false, { template })
        else
          vim.api.nvim_buf_set_lines(buf, 0, 0, false, { template })
        end

        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_win_set_cursor(win, { 1, math.max(0, #template - 2) })
        end
      end,
    })
  end,
  cmd = { "Neogit" },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Neogit status",
    },
    {
      "<leader>gG",
      function()
        require("neogit").open({ kind = "vsplit" })
      end,
      desc = "Neogit status (vsplit)",
    },
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
}
