return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    config = function()
      require("go").setup({
        lsp_cfg = false,
        dap_debug = false,
        trouble = false,
      })

      local function set_go_coverage_maps(bufnr)
        vim.keymap.set("n", "<leader>gs", ":GoCoverage<CR>", {
          buffer = bufnr,
          desc = "Go: Show coverage",
        })
        vim.keymap.set("n", "<leader>gS", ":GoCoverageClear<CR>", {
          buffer = bufnr,
          desc = "Go: Clear coverage",
        })
      end

      local go_fts = {
        go = true,
        gomod = true,
        gowork = true,
        gosum = true,
        gotmpl = true,
      }

      -- Keep coverage mappings buffer-local so global git mappings stay stable.
      local group = vim.api.nvim_create_augroup("GoCoverageBufferMaps", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = { "go", "gomod", "gowork", "gosum", "gotmpl" },
        callback = function(args)
          set_go_coverage_maps(args.buf)
        end,
      })

      -- Apply immediately for already-open Go buffers (including the current one).
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) and go_fts[vim.bo[bufnr].filetype] then
          set_go_coverage_maps(bufnr)
        end
      end
    end,
    event = {"CmdlineEnter"},
    ft = { "go", "gomod", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()'
  }
}
