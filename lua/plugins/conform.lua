-- Plugin to provide formatting using external tools (including sql-formatter)
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        sql = { "sql_formatter" },
      },
    })
  end,
}
