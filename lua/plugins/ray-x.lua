return {
  {
    "gen740/SmoothCursor.nvim",
    enabled = false,
    event = { "CursorMoved", "CursorMovedI" },
    config = function()
      require("smoothcursor").setup({
        type = "default", -- "default", "exp", "matrix", "pulse"
        fancy = {
          enable = true,
          head = { cursor = "⬤", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "•", texthl = "SmoothCursorRed" },
            { cursor = "•", texthl = "SmoothCursorOrange" },
            { cursor = "•", texthl = "SmoothCursorYellow" },
            { cursor = "•", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = "•", texthl = "SmoothCursorBlue" },
            { cursor = "•", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = nil },
        },
        autostart = true,
        flyin_effect = "bottom",
        speed = 35, -- Increase for smoother, higher-fps feel
        intervals = 15, -- Lower intervals yields more updates
        priority = 10,
        timeout = 3000,
        threshold = 1,
        disable_float_win = true,
        enabled_filetypes = nil,
        disabled_filetypes = nil,
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("go").setup()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
      -- Use unified LSP rename mapping (<leader>rn) from lsp-config on_attach
    end,
    event = {"CmdlineEnter"},
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()'
  }
}
