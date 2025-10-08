return {
  {
    "keaising/im-select.nvim",
    event = "VeryLazy",
    opts = {
      -- macOS input source to use for Normal mode
      -- Use `im-select` in a shell to see available IDs
      default_im_select = "com.apple.keylayout.ABC",

      -- Switch to English on leaving typing contexts
      set_default_events = { "VimEnter", "InsertLeave", "CmdlineLeave" },

      -- Restore the previously-used input method on entering typing contexts
      set_previous_events = { "InsertEnter", "CmdlineEnter" },

      -- Switch without blocking UI
      async_switch = true,

      -- Don't spam if the binary is missing yet
      keep_quiet_on_no_binary = true,
    },
    config = function(_, opts)
      local function has_binary()
        return vim.fn.executable('im-select') == 1
      end

      if has_binary() then
        require('im_select').setup(opts)
      end

      -- Lightweight debug helpers
      local function get_current()
        if has_binary() == false then return nil end
        local out = vim.fn.systemlist('im-select')
        if vim.v.shell_error ~= 0 or not out or #out == 0 then return nil end
        return (out[1] or ''):gsub('%s+$','')
      end
      local function set_im(id)
        if has_binary() == false then return false end
        vim.fn.system({ 'im-select', id })
        return vim.v.shell_error == 0
      end

      vim.api.nvim_create_user_command('IMSelectCurrent', function()
        local cur = get_current()
        if not has_binary() then
          vim.notify('im-select binary not found in PATH', vim.log.levels.WARN)
          return
        end
        vim.notify('Current input source: ' .. (cur or 'unknown'), vim.log.levels.INFO)
      end, {})

      vim.api.nvim_create_user_command('IMSelectSet', function(cmd)
        local ok = set_im(cmd.args)
        if not ok then
          vim.notify('Failed to set input source to ' .. cmd.args, vim.log.levels.ERROR)
        end
      end, { nargs = 1, complete = function()
        -- Not all versions of im-select can list; provide common IDs as hints
        return {
          'com.apple.keylayout.ABC',
          'com.apple.keylayout.US',
          'com.apple.inputmethod.Korean.2SetKorean',
          'com.apple.keylayout.RussianWin',
        }
      end })

      -- Compatibility autocmds: enforce switching even if plugin events don't fire as expected
      if has_binary() then
        local grp = vim.api.nvim_create_augroup('im_select_compat', { clear = true })
        local last_insert_im = nil

        vim.api.nvim_create_autocmd('InsertLeave', {
          group = grp,
          callback = function()
            local cur = get_current()
            if cur and cur ~= '' then last_insert_im = cur end
            if opts.default_im_select and opts.default_im_select ~= '' then
              set_im(opts.default_im_select)
            end
          end,
        })

        vim.api.nvim_create_autocmd('CmdlineLeave', {
          group = grp,
          callback = function()
            if opts.default_im_select and opts.default_im_select ~= '' then
              set_im(opts.default_im_select)
            end
          end,
        })

        vim.api.nvim_create_autocmd('InsertEnter', {
          group = grp,
          callback = function()
            if last_insert_im and last_insert_im ~= '' then
              set_im(last_insert_im)
            end
          end,
        })

        vim.api.nvim_create_autocmd('CmdlineEnter', {
          group = grp,
          callback = function()
            if last_insert_im and last_insert_im ~= '' then
              set_im(last_insert_im)
            end
          end,
        })
      end

      -- No fallback here by request; IME switching requires im-select installed.
    end,
  },
}
