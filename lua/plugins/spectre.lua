return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local spectre = require("spectre")
      spectre.setup({
        default = {
          find = {
            -- Show hidden files and use smart case
            options = { "--hidden" },
          },
        },
        -- Keep defaults concise; Telescope already handles path display nicely elsewhere
      })

      -- Project-wide search/replace UI
      vim.keymap.set('n', '<leader>sr', function()
        spectre.open()
      end, { desc = "Spectre: search/replace project" })

      -- Search current word (project)
      vim.keymap.set('n', '<leader>sw', function()
        spectre.open_visual({ select_word = true })
      end, { desc = "Spectre: search word under cursor" })

      -- Search selection (visual)
      vim.keymap.set('v', '<leader>sw', function()
        spectre.open_visual()
      end, { desc = "Spectre: search visual selection" })

      -- File-scoped search/replace UI
      vim.keymap.set('n', '<leader>sf', function()
        spectre.open_file_search({ select_word = true })
      end, { desc = "Spectre: search/replace in file" })
    end,
  }
}

