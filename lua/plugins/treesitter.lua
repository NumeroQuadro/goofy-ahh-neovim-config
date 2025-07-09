return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
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
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin
        })
    end
}
