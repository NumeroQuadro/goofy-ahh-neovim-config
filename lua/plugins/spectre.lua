return {
  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Spectre" },
    keys = {
      { "<leader>sp", function() require('spectre').open() end,            desc = "Spectre: Project find/replace" },
      { "<leader>sf", function() require('spectre').open_file_search() end,  desc = "Spectre: File find/replace" },
      { "<leader>sw", function() require('spectre').open_visual({ select_word = true }) end, mode = {"n","x"}, desc = "Spectre: Search word" },
    },
    config = function()
      local ok, spectre = pcall(require, 'spectre')
      if not ok then return end

      spectre.setup({
        live_update = true,
        highlight = { ui = "String", search = "IncSearch", replace = "DiffChange" },
        -- Use Spectre's defaults for panel keymaps to avoid API drift
      })
    end,
  },
}
