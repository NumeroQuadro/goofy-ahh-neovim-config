return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    config = function()
      require("go").setup({
        lsp_cfg = true,
        dap_debug = false,
        trouble = true,
      })

      -- Optional: quick coverage keymaps
      vim.keymap.set("n", "<leader>gs", ":GoCoverage<CR>", { desc = "Go: Show coverage" })
      vim.keymap.set("n", "<leader>gS", ":GoCoverageClear<CR>", { desc = "Go: Clear coverage" })
    end,
    event = {"CmdlineEnter"},
    ft = { "go", "gomod", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()'
  }
}
