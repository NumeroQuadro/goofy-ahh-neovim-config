return {
  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Spectre" },
    keys = {
      { "<leader>sp", function() require('spectre').open() end,            desc = "Spectre: Project find/replace" },
      { "<leader>sf", function() require('spectre').open_file_search() end,  desc = "Spectre: File find/replace" },
      { "<leader>sw", function() require('spectre').open_visual({ select_word = true }) end, mode = {"n","x"}, desc = "Spectre: Search word" },
      { "<leader>sr", function() require('spectre').toggle() end,            desc = "Spectre: Toggle panel" },
    },
    config = function()
      local ok, spectre = pcall(require, 'spectre')
      if not ok then return end

      spectre.setup({
        live_update = true,
        highlight = { ui = "String", search = "IncSearch", replace = "DiffChange" },
        mapping = {
          -- Select entries by file or by line, then run replace only for selected
          ["toggle_file"] = { map = "<CR>", cmd = "<cmd>lua require('spectre.actions').toggle_file()<CR>", desc = "Toggle file selection" },
          ["toggle_line"] = { map = "<Tab>", cmd = "<cmd>lua require('spectre.actions').toggle_line()<CR>", desc = "Toggle line selection" },
          ["run_replace"] = { map = "r", cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>", desc = "Apply to selected" },
          ["run_current_replace"] = { map = "R", cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>", desc = "Apply current file" },
          ["show_options"] = { map = "o", cmd = "<cmd>lua require('spectre.actions').show_options()<CR>", desc = "Show options" },
          ["enter_file"] = { map = "gf", cmd = "<cmd>lua require('spectre.actions').enter_file()<CR>", desc = "Open file under cursor" },
          ["send_to_qf"] = { map = "Q", cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>", desc = "Send results to quickfix" },
          ["replace_cmd"] = { map = "c", cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>", desc = "Input replace (sed)" },
        },
      })
    end,
  },
}
