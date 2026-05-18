return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local im_select = vim.fn.exepath("im-select")
        local uv = vim.uv or vim.loop
        local keyboard_cache = {
            at = 0,
            id = "",
            label = "??",
        }

        local keyboard_labels = {
            ["com.apple.keylayout.ABC"] = "EN",
            ["com.apple.keylayout.US"] = "EN",
            ["com.apple.keylayout.British"] = "EN",
            ["com.apple.keylayout.Dvorak"] = "EN",
            ["com.apple.keylayout.Colemak"] = "EN",
            ["com.apple.keylayout.Russian"] = "RU",
            ["com.apple.keylayout.RussianWin"] = "RU",
        }

        local function label_for_input_source(source_id)
            local exact = keyboard_labels[source_id]
            if exact then
                return exact
            end

            local lower = string.lower(source_id)
            if lower:find("russian", 1, true) or lower:find("cyrillic", 1, true) then
                return "RU"
            end
            if lower:find("abc", 1, true)
                or lower:find("us", 1, true)
                or lower:find("british", 1, true)
                or lower:find("dvorak", 1, true)
                or lower:find("colemak", 1, true) then
                return "EN"
            end

            local short = source_id:match("%.([^%.]+)$") or source_id
            return string.upper(short:sub(1, 6))
        end

        local function keyboard_label()
            if im_select == "" then
                return "--"
            end

            local now = uv.now()
            if now - keyboard_cache.at < 500 then
                return keyboard_cache.label
            end

            local source_id = vim.fn.system({ im_select }):gsub("%s+$", "")
            keyboard_cache.at = now
            if vim.v.shell_error ~= 0 or source_id == "" then
                keyboard_cache.id = ""
                keyboard_cache.label = "??"
                return keyboard_cache.label
            end

            keyboard_cache.id = source_id
            keyboard_cache.label = label_for_input_source(source_id)
            return keyboard_cache.label
        end

        local keyboard_component = {
            function()
                return "KB: " .. keyboard_label()
            end,
            cond = function()
                return im_select ~= ""
            end,
            color = function()
                local label = keyboard_label()
                if label == "RU" then
                    return { fg = "#282a36", bg = "#ffb86c", gui = "bold" }
                end
                if label == "EN" then
                    return { fg = "#282a36", bg = "#50fa7b", gui = "bold" }
                end
                return { fg = "#f8f8f2", bg = "#6272a4", gui = "bold" }
            end,
        }

        require('lualine').setup({
            options = {
                theme = 'dracula'
            },
            sections = {
                lualine_c = {
                    'filename',
                    {
                        'modified',
                        symbols = {modified = '+', readonly = '-'},
                    }
                },
                lualine_x = {
                    keyboard_component,
                    'encoding',
                    'fileformat',
                    'filetype',
                },
            }
        })

        if im_select ~= "" then
            local group = vim.api.nvim_create_augroup("KeyboardLayoutLualine", { clear = true })
            local function refresh_keyboard_status()
                keyboard_cache.at = 0
                pcall(require('lualine').refresh, { place = { 'statusline' } })
            end

            vim.api.nvim_create_autocmd({ "FocusGained", "InsertEnter", "InsertLeave", "ModeChanged" }, {
                group = group,
                callback = refresh_keyboard_status,
            })

            local timer = uv.new_timer()
            if timer then
                timer:start(1000, 1000, vim.schedule_wrap(refresh_keyboard_status))
                vim.api.nvim_create_autocmd("VimLeavePre", {
                    group = group,
                    once = true,
                    callback = function()
                        timer:stop()
                        timer:close()
                    end,
                })
            end
        end
    end
}
