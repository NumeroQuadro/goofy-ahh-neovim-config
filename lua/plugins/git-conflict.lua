return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
      "GitConflictPick",
    },
    keys = {
      { "]x", "<cmd>GitConflictNextConflict<CR>", desc = "Conflict: Next" },
      { "[x", "<cmd>GitConflictPrevConflict<CR>", desc = "Conflict: Previous" },
      { "<leader>co", "<cmd>GitConflictChooseOurs<CR>", desc = "Conflict: Choose ours" },
      { "<leader>ct", "<cmd>GitConflictChooseTheirs<CR>", desc = "Conflict: Choose theirs" },
      { "<leader>cb", "<cmd>GitConflictChooseBoth<CR>", desc = "Conflict: Choose both" },
      { "<leader>c0", "<cmd>GitConflictChooseNone<CR>", desc = "Conflict: Choose none" },
      { "<leader>cm", "<cmd>GitConflictPick<CR>", desc = "Conflict: Resolve picker" },
      { "<leader>cq", "<cmd>GitConflictListQf<CR>", desc = "Conflict: List quickfix" },
      { "<leader>cv", "<cmd>DiffviewOpen<CR>", desc = "Conflict: Open merge diff view" },
      { "<leader>cV", "<cmd>DiffviewClose<CR>", desc = "Conflict: Close merge diff view" },
    },
    opts = {
      default_mappings = false,
      default_commands = true,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        current = "DiffDelete",
      },
    },
    config = function(_, opts)
      require("git-conflict").setup(opts)

      local actions = {
        {
          label = "Accept ours (current branch) and jump next",
          command = "GitConflictChooseOurs",
          jump_next = true,
        },
        {
          label = "Accept theirs (incoming branch) and jump next",
          command = "GitConflictChooseTheirs",
          jump_next = true,
        },
        {
          label = "Accept both and jump next",
          command = "GitConflictChooseBoth",
          jump_next = true,
        },
        {
          label = "Accept none and jump next",
          command = "GitConflictChooseNone",
          jump_next = true,
        },
        { label = "Jump to next conflict", command = "GitConflictNextConflict" },
        { label = "Jump to previous conflict", command = "GitConflictPrevConflict" },
        { label = "Open Diffview merge UI", command = "DiffviewOpen" },
      }

      pcall(vim.api.nvim_del_user_command, "GitConflictPick")
      vim.api.nvim_create_user_command("GitConflictPick", function()
        vim.ui.select(actions, {
          prompt = "Resolve conflict chunk",
          format_item = function(item)
            return item.label
          end,
        }, function(choice)
          if not choice then
            return
          end

          local ok, err = pcall(vim.cmd, choice.command)
          if not ok then
            vim.notify(("Conflict action failed: %s"):format(err), vim.log.levels.ERROR)
            return
          end

          if choice.jump_next then
            pcall(vim.cmd, "GitConflictNextConflict")
          end
        end)
      end, { desc = "Pick a conflict resolution action for the current chunk" })
    end,
  },
}
