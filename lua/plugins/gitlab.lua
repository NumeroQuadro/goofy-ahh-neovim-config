return {
  "harrisoncramer/gitlab.nvim",
  branch = "main",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "dlyongemallo/diffview-plus.nvim",
    {
      "stevearc/dressing.nvim",
      opts = {
        select = { enabled = true },
      },
    },
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>gM",
      function()
        require("gitlab").choose_merge_request()
      end,
      desc = "GitLab: Choose merge request",
    },
    {
      "<leader>gR",
      function()
        require("gitlab").review()
      end,
      desc = "GitLab: Review current merge request",
    },
    {
      "<leader>gX",
      function()
        require("gitlab").close_review()
      end,
      desc = "GitLab: Close merge request review",
    },
  },
  opts = {},
}
