return {
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageSummary",
      "CoverageClear",
    },
    keys = {
      { "<leader>cl", "<cmd>CoverageLoad<CR>",   desc = "Coverage: Load profile" },
      { "<leader>cs", "<cmd>CoverageShow<CR>",   desc = "Coverage: Show highlights" },
      { "<leader>ch", "<cmd>CoverageHide<CR>",   desc = "Coverage: Hide highlights" },
      { "<leader>cc", "<cmd>CoverageClear<CR>",  desc = "Coverage: Clear coverage" },
    },
    config = function()
      local ok, coverage = pcall(require, "coverage")
      if not ok then return end
      coverage.setup({
        auto_reload = true,
      })

      local function apply_coverage_highlights()
        -- Green for covered, red for uncovered (subtle backgrounds)
        vim.api.nvim_set_hl(0, "CoverageCovered",   { bg = "#16381d" })
        vim.api.nvim_set_hl(0, "CoverageUncovered", { bg = "#3b0e0e" })
      end

      apply_coverage_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("CoverageHL", { clear = true }),
        callback = apply_coverage_highlights,
      })

      -- When a coverage profile is written, reload and show it
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("CoverageAutoReload", { clear = true }),
        pattern = "coverage.out",
        callback = function()
          vim.cmd("CoverageLoad | CoverageShow")
        end,
      })
    end,
  },
}

