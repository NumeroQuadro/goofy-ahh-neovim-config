return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                  "c",
                  "lua",
                  "vim",
                  "vimdoc",
                  "query",
                  "elixir",
                  "heex",
                  "javascript",
                  "html",
                  "go",      -- for Golang
                  "proto",   -- for Protocol Buffers (proto3)
                  "sql",     -- for SQL
            },
        highlight = { enable = true },
        indent = { enable = true },
    })
    end
}
