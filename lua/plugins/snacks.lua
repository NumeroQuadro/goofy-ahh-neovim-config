return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = false,
        float = true,
        max_width = 60,
        max_height = 22,
      },
    },
    styles = {
      snacks_image = {
        relative = "cursor",
        border = "rounded",
        focusable = false,
        backdrop = false,
        row = 1,
        col = 1,
      },
    },
  },
  keys = {
    {
      "<leader>P",
      function()
        if _G.Snacks and Snacks.image then
          Snacks.image.hover()
        else
          vim.notify("Image preview is not available", vim.log.levels.WARN)
        end
      end,
      desc = "Preview image under cursor",
    },
  },
}
