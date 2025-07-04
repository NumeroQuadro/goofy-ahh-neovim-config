return {
  "ray-x/go.nvim",
  dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
<<<<<<< HEAD
  config = function()
=======
    config = function()
>>>>>>> e33f9a9 (actual setup)
    require("go").setup()
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
<<<<<<< HEAD
  end,
  ft = { "go", "gomod" },
=======
    end,
    event = {"CmdlineEnter"},
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()'
>>>>>>> e33f9a9 (actual setup)
}

