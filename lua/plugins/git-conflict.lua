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
    },
    keys = {
      { "]x", "<cmd>GitConflictNextConflict<CR>", desc = "Conflict: Next" },
      { "[x", "<cmd>GitConflictPrevConflict<CR>", desc = "Conflict: Previous" },
      { "<leader>co", "<cmd>GitConflictChooseOurs<CR>", desc = "Conflict: Choose ours" },
      { "<leader>ct", "<cmd>GitConflictChooseTheirs<CR>", desc = "Conflict: Choose theirs" },
      { "<leader>cb", "<cmd>GitConflictChooseBoth<CR>", desc = "Conflict: Choose both" },
      { "<leader>c0", "<cmd>GitConflictChooseNone<CR>", desc = "Conflict: Choose none" },
      { "<leader>cq", "<cmd>GitConflictListQf<CR>", desc = "Conflict: List quickfix" },
    },
    opts = {
      default_mappings = false,
      default_commands = true,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
  },
}
