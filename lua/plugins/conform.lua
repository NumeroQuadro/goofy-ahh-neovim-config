-- Plugin to provide formatting using external tools (including sql-formatter)
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        sql = { "sql_formatter" },
        kotlin = { "ktlint" },
      },
    })

    -- Optional: format Kotlin on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.kt", "*.kts" },
      callback = function(args)
        conform.format({ bufnr = args.buf, lsp_fallback = true, quiet = true })
      end,
      group = vim.api.nvim_create_augroup("ConformKotlinFormatOnSave", { clear = true }),
    })
  end,
}
