return {
  "declancm/cinnamon.nvim",
  event = "VeryLazy",
  config = function()
    require("cinnamon").setup({
      -- KEYMAPS
      -- To use the default keymaps, put this in your config
      default_keymaps = true,

      -- To use custom keymaps, define them here
      -- keymaps = {
      --   -- For example:
      --   split_left = "<C-h>",
      --   split_down = "<C-j>",
      --   split_up = "<C-k>",
      --   split_right = "<C-l>",
      -- },

      -- OPTIONS
      -- For a list of all options, see the documentation
      options = {
        -- These are the default options
        always_scroll = false, -- Scroll even if the cursor remains in view
        centered = true, -- Keep the cursor centered in the window
        show_cursor = false, -- Show the cursor while scrolling
        scroll_limit = -1, -- How many lines to scroll at a time
        scroll_speed = 10, -- How fast to scroll
        easing = "linear", -- The easing function to use
      },

      -- EXTRA
      -- For extra configuration, see the documentation
      extra = {
        -- These are the default extra options
        always_scroll = false,
        centered = true,
        show_cursor = false,
        scroll_limit = -1,
        scroll_speed = 10,
        easing = "linear",
      },
    })
  end,
}
