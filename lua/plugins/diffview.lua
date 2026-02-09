return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
    },
    init = function()
        local function ensure_loaded()
            if vim.fn.exists(":DiffviewOpen") == 2 then return true end
            local ok = pcall(require, "lazy")
            if ok then
                pcall(require("lazy").load, { plugins = { "diffview.nvim" } })
            end
            return true
        end

        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, function()
                ensure_loaded()
                rhs()
            end, { silent = true, desc = desc })
        end

        map("<leader>gd", function() vim.cmd.DiffviewOpen() end, "Diffview: Open")
        map("<leader>gq", function() vim.cmd.DiffviewClose() end, "Diffview: Close")
        map("<leader>gh", function() vim.cmd("DiffviewFileHistory %") end, "Diffview: File history (file)")
        map("<leader>gH", function() vim.cmd.DiffviewFileHistory() end, "Diffview: File history (repo)")
    end,
    config = function()
        local diffview = require("diffview")
        local actions = require("diffview.actions")

        diffview.setup({
            enhanced_diff_hl = true,
            use_icons = true,
            file_panel = {
                win_config = { position = "left", width = 28 },
            },
            view = {
                default = {
                    layout = "diff2_horizontal",
                },
                merge_tool = {
                    layout = "diff3_mixed",
                },
            },
            hooks = {
                diff_buf_read = function()
                    -- Keep Diffview windows dense/readable without changing global options.
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false
                    vim.opt_local.signcolumn = "no"
                    vim.opt_local.foldcolumn = "0"
                end,
            },
            keymaps = {
                view = {
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file_edit,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["<leader>b"] = actions.toggle_files,
                    ["<leader>e"] = actions.focus_files,
                    ["g<C-x>"] = actions.cycle_layout,
                },
                file_panel = {
                    ["j"] = actions.next_entry,
                    ["k"] = actions.prev_entry,
                    ["<cr>"] = actions.select_entry,
                    ["s"] = actions.toggle_stage_entry,
                    ["S"] = actions.stage_all,
                    ["U"] = actions.unstage_all,
                    ["X"] = actions.restore_entry,
                    ["R"] = actions.refresh_files,
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["<leader>b"] = actions.toggle_files,
                    ["<leader>e"] = actions.focus_files,
                    ["g<C-x>"] = actions.cycle_layout,
                },
            },
        })
    end,
}
