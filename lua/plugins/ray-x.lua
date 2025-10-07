return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("go").setup({
        -- We configure gopls in lsp-config.lua; avoid starting another client here
        lsp_cfg = false,
      })
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
