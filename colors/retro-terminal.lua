-- Retro Terminal Colorscheme
-- Pure white background with saturated blue text (inspired by S4AD vintage terminal aesthetic)

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "retro-terminal"
vim.o.background = "light"

local c = {
  -- Pure white background
  bg = "#FFFFFF",
  bg_dark = "#F5F5F5",
  bg_darker = "#EBEBEB",
  
  -- Blue text - saturated for highlights, less saturated for regular
  fg = "#2B4B8C",              -- Regular text - medium blue
  fg_bright = "#0000CD",       -- Highlighted/keywords - very saturated blue
  fg_dim = "#5A6A9A",          -- Dimmed text (comments)
  fg_muted = "#8899BB",        -- Very muted
  
  -- Accent colors
  blue = "#2B4B8C",            -- Primary blue
  blue_bright = "#0000CD",     -- Saturated blue for emphasis
  blue_dark = "#00008B",       -- Dark blue
  cyan = "#0066AA",
  green = "#0055AA",           -- Keep in blue family
  yellow = "#5555AA",
  orange = "#4444AA",
  red = "#4444CC",             -- Blueish red for errors
  
  -- UI
  border = "#AABBDD",
  visual = "#C0D0FF",          -- Light blue selection
  search = "#AACCFF",          -- Light blue search
  cursorline = "#F0F4FF",      -- Very subtle blue tint
}

local function hi(g, o)
  local cmd = "hi " .. g
  if o.fg then cmd = cmd .. " guifg=" .. o.fg end
  if o.bg then cmd = cmd .. " guibg=" .. o.bg end
  if o.sp then cmd = cmd .. " guisp=" .. o.sp end
  local s = {}
  if o.bold then table.insert(s, "bold") end
  if o.italic then table.insert(s, "italic") end
  if o.underline then table.insert(s, "underline") end
  if o.undercurl then table.insert(s, "undercurl") end
  cmd = cmd .. " gui=" .. (#s > 0 and table.concat(s, ",") or "NONE")
  vim.cmd(cmd)
end

-- UI
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_dark })
hi("FloatBorder", { fg = c.border, bg = c.bg_dark })
hi("Cursor", { fg = c.bg, bg = c.blue_bright })
hi("CursorLine", { bg = c.cursorline })
hi("CursorColumn", { bg = c.cursorline })
hi("ColorColumn", { bg = c.bg_dark })
hi("LineNr", { fg = c.fg_muted, bg = c.bg })
hi("CursorLineNr", { fg = c.blue_bright, bg = c.cursorline, bold = true })
hi("SignColumn", { fg = c.fg_dim, bg = c.bg })
hi("VertSplit", { fg = c.border, bg = c.bg })
hi("WinSeparator", { fg = c.border, bg = c.bg })
hi("Folded", { fg = c.fg_dim, bg = c.bg_dark })
hi("MatchParen", { fg = c.blue_bright, bg = c.visual, bold = true })
hi("NonText", { fg = c.border })
hi("EndOfBuffer", { fg = c.bg_dark })
hi("StatusLine", { fg = c.fg, bg = c.bg_dark })
hi("StatusLineNC", { fg = c.fg_muted, bg = c.bg_darker })
hi("TabLine", { fg = c.fg_dim, bg = c.bg_dark })
hi("TabLineSel", { fg = c.blue_bright, bg = c.bg, bold = true })
hi("TabLineFill", { bg = c.bg_dark })
hi("Pmenu", { fg = c.fg, bg = c.bg_dark })
hi("PmenuSel", { fg = c.bg, bg = c.blue_bright })
hi("PmenuSbar", { bg = c.bg_darker })
hi("PmenuThumb", { bg = c.border })
hi("Visual", { bg = c.visual })
hi("Search", { fg = c.blue_dark, bg = c.search })
hi("IncSearch", { fg = c.bg, bg = c.blue_bright, bold = true })
hi("CurSearch", { fg = c.bg, bg = c.blue_bright, bold = true })
hi("ErrorMsg", { fg = c.red, bold = true })
hi("WarningMsg", { fg = c.yellow, bold = true })
hi("ModeMsg", { fg = c.blue_bright, bold = true })
hi("Title", { fg = c.blue_bright, bold = true })
hi("Directory", { fg = c.blue_bright })
hi("DiffAdd", { fg = c.green, bg = "#E8F0FF" })
hi("DiffChange", { fg = c.yellow, bg = "#F0F0FF" })
hi("DiffDelete", { fg = c.red, bg = "#F0E8FF" })
hi("DiffText", { fg = c.blue_dark, bg = "#D0E0FF", bold = true })
hi("SpellBad", { sp = c.red, undercurl = true })

-- Syntax - using blue spectrum with varying saturation
hi("Comment", { fg = c.fg_dim })
hi("Constant", { fg = c.blue_bright })
hi("String", { fg = c.fg })
hi("Character", { fg = c.fg })
hi("Number", { fg = c.blue_bright })
hi("Boolean", { fg = c.blue_bright, bold = true })
hi("Float", { fg = c.blue_bright })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.blue_bright, bold = true })
hi("Statement", { fg = c.blue_bright, bold = true })
hi("Conditional", { fg = c.blue_bright, bold = true })
hi("Repeat", { fg = c.blue_bright, bold = true })
hi("Label", { fg = c.blue_bright })
hi("Operator", { fg = c.fg })
hi("Keyword", { fg = c.blue_bright, bold = true })
hi("Exception", { fg = c.blue_bright, bold = true })
hi("PreProc", { fg = c.blue_bright })
hi("Include", { fg = c.blue_bright })
hi("Define", { fg = c.blue_bright })
hi("Macro", { fg = c.blue_bright })
hi("Type", { fg = c.blue_bright })
hi("StorageClass", { fg = c.blue_bright, bold = true })
hi("Structure", { fg = c.blue_bright })
hi("Typedef", { fg = c.blue_bright })
hi("Special", { fg = c.blue_bright })
hi("SpecialChar", { fg = c.blue_bright })
hi("Tag", { fg = c.blue_bright })
hi("Delimiter", { fg = c.fg })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.bg, bg = c.blue_bright, bold = true })

-- Treesitter
hi("@comment", { fg = c.fg_dim })
hi("@punctuation", { fg = c.fg })
hi("@constant", { fg = c.blue_bright })
hi("@constant.builtin", { fg = c.blue_bright, bold = true })
hi("@string", { fg = c.fg })
hi("@string.escape", { fg = c.blue_bright })
hi("@number", { fg = c.blue_bright })
hi("@boolean", { fg = c.blue_bright, bold = true })
hi("@function", { fg = c.blue_bright, bold = true })
hi("@function.builtin", { fg = c.blue_bright })
hi("@keyword", { fg = c.blue_bright, bold = true })
hi("@keyword.function", { fg = c.blue_bright, bold = true })
hi("@keyword.return", { fg = c.blue_bright, bold = true })
hi("@conditional", { fg = c.blue_bright, bold = true })
hi("@repeat", { fg = c.blue_bright, bold = true })
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.blue_bright })
hi("@parameter", { fg = c.fg })
hi("@type", { fg = c.blue_bright })
hi("@type.builtin", { fg = c.blue_bright })
hi("@namespace", { fg = c.blue_bright })
hi("@include", { fg = c.blue_bright })

-- Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.cyan })
hi("DiagnosticHint", { fg = c.fg_dim })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })

-- Git
hi("GitSignsAdd", { fg = c.blue_bright })
hi("GitSignsChange", { fg = c.fg })
hi("GitSignsDelete", { fg = c.red })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg })
hi("TelescopeBorder", { fg = c.border, bg = c.bg })
hi("TelescopeSelection", { fg = c.fg, bg = c.visual })
hi("TelescopeMatching", { fg = c.blue_bright, bold = true })

-- Bufferline
hi("BufferLineFill", { bg = c.bg_dark })
hi("BufferLineBackground", { fg = c.fg_dim, bg = c.bg_dark })
hi("BufferLineBufferSelected", { fg = c.blue_bright, bg = c.bg, bold = true })

-- netrw
hi("netrwDir", { fg = c.blue_bright })
hi("netrwExe", { fg = c.blue_bright, bold = true })
