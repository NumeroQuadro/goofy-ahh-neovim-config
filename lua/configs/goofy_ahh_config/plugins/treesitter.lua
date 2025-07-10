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

            textobjects = {
              select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                  ["ia"] = "@parameter.inner",
                  ["aa"] = "@parameter.outer",
                },
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]f"] = "@function.outer",
                  ["]c"] = "@class.outer",
                },
                goto_previous_start = {
                  ["[f"] = "@function.outer",
                  ["[c"] = "@class.outer",
                },
              },
              swap = {
                enable = true,
                swap_next = {
                  ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                  ["<leader>A"] = "@parameter.inner",
                },
              },
            },
        })
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin
        })
    end
}
