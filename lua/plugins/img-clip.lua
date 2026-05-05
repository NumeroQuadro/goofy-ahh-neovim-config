return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      dir_path = "assets",
      file_name = "%Y-%m-%d-%H-%M-%S",
      use_absolute_path = false,
      relative_to_current_file = true,
      prompt_for_file_name = false,
    },
    filetypes = {
      markdown = {
        template = "![$CURSOR]($FILE_PATH)",
        url_encode_path = true,
      },
    },
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<CR>", desc = "Paste image from clipboard" },
  },
}
