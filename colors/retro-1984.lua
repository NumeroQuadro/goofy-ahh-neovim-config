-- Retro 1984 colorscheme
-- VHS/CRT payphone aesthetic: dark chassis, cobalt panels, phosphor green copy.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "retro-1984"
vim.o.background = "dark"

local c = {
  bg = "#040B0B",
  bg_dark = "#020606",
  panel = "#0C3C95",
  panel_dark = "#082A67",
  panel_soft = "#1450B5",
  fg = "#CFEFC8",
  fg_dim = "#89C8A0",
  green = "#36F38A",
  green_soft = "#6AFFA8",
  cyan = "#62CFFF",
  amber = "#E0D77A",
  red = "#FF5F6D",
  border = "#0EC66F",
  muted = "#2B5D49",
}

local function hi(group, opts)
  local cmd = "hi " .. group
  if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
  if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
  if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end

  local styles = {}
  if opts.bold then table.insert(styles, "bold") end
  if opts.italic then table.insert(styles, "italic") end
  if opts.underline then table.insert(styles, "underline") end
  if opts.undercurl then table.insert(styles, "undercurl") end
  cmd = cmd .. " gui=" .. (#styles > 0 and table.concat(styles, ",") or "NONE")
  vim.cmd(cmd)
end

-- UI shell
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalNC", { fg = c.fg_dim, bg = c.bg_dark })
hi("NormalFloat", { fg = c.fg, bg = c.panel_dark })
hi("FloatBorder", { fg = c.border, bg = c.panel_dark })
hi("Cursor", { fg = c.bg, bg = c.green })
hi("CursorLine", { bg = c.bg_dark })
hi("CursorColumn", { bg = c.bg_dark })
hi("ColorColumn", { bg = c.bg_dark })
hi("LineNr", { fg = c.muted, bg = c.bg })
hi("CursorLineNr", { fg = c.green_soft, bg = c.bg_dark, bold = true })
hi("SignColumn", { fg = c.fg_dim, bg = c.bg })
hi("WinSeparator", { fg = c.border, bg = c.bg })
hi("VertSplit", { fg = c.border, bg = c.bg })
hi("Folded", { fg = c.fg_dim, bg = c.bg_dark })
hi("MatchParen", { fg = c.green_soft, bg = c.panel_dark, bold = true })
hi("NonText", { fg = c.muted })
hi("EndOfBuffer", { fg = c.bg_dark })

-- Blue "card" areas inspired by legacy service terminals
hi("StatusLine", { fg = c.fg, bg = c.panel, bold = true })
hi("StatusLineNC", { fg = c.fg_dim, bg = c.panel_dark })
hi("TabLine", { fg = c.fg_dim, bg = c.bg_dark })
hi("TabLineSel", { fg = c.fg, bg = c.panel_soft, bold = true })
hi("TabLineFill", { bg = c.bg_dark })
hi("Pmenu", { fg = c.fg, bg = c.panel_dark })
hi("PmenuSel", { fg = c.bg, bg = c.green, bold = true })
hi("PmenuSbar", { bg = c.bg_dark })
hi("PmenuThumb", { bg = c.border })
hi("Visual", { bg = c.panel_dark })
hi("Search", { fg = c.bg, bg = c.green_soft })
hi("IncSearch", { fg = c.bg, bg = c.green, bold = true })
hi("CurSearch", { fg = c.bg, bg = c.green, bold = true })
hi("ErrorMsg", { fg = c.red, bold = true })
hi("WarningMsg", { fg = c.amber, bold = true })
hi("ModeMsg", { fg = c.green_soft, bold = true })
hi("Title", { fg = c.green_soft, bold = true })
hi("Directory", { fg = c.cyan, bold = true })
hi("DiffAdd", { fg = c.green, bg = "#0B2D1B" })
hi("DiffChange", { fg = c.cyan, bg = "#072341" })
hi("DiffDelete", { fg = c.red, bg = "#2A1216" })
hi("DiffText", { fg = c.bg, bg = c.green, bold = true })
hi("SpellBad", { sp = c.red, undercurl = true })

-- Syntax
hi("Comment", { fg = c.fg_dim, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green_soft })
hi("Character", { fg = c.green_soft })
hi("Number", { fg = c.amber })
hi("Boolean", { fg = c.amber, bold = true })
hi("Float", { fg = c.amber })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.cyan, bold = true })
hi("Statement", { fg = c.green, bold = true })
hi("Conditional", { fg = c.green, bold = true })
hi("Repeat", { fg = c.green, bold = true })
hi("Label", { fg = c.green_soft })
hi("Operator", { fg = c.fg })
hi("Keyword", { fg = c.green, bold = true })
hi("Exception", { fg = c.red, bold = true })
hi("PreProc", { fg = c.cyan })
hi("Include", { fg = c.cyan })
hi("Define", { fg = c.cyan })
hi("Macro", { fg = c.cyan })
hi("Type", { fg = c.cyan, bold = true })
hi("StorageClass", { fg = c.cyan, bold = true })
hi("Structure", { fg = c.cyan })
hi("Typedef", { fg = c.cyan })
hi("Special", { fg = c.amber })
hi("SpecialChar", { fg = c.amber })
hi("Tag", { fg = c.green_soft })
hi("Delimiter", { fg = c.fg })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.bg, bg = c.amber, bold = true })

-- Treesitter
hi("@comment", { fg = c.fg_dim, italic = true })
hi("@punctuation", { fg = c.fg })
hi("@constant", { fg = c.cyan })
hi("@constant.builtin", { fg = c.cyan, bold = true })
hi("@string", { fg = c.green_soft })
hi("@string.escape", { fg = c.amber })
hi("@number", { fg = c.amber })
hi("@boolean", { fg = c.amber, bold = true })
hi("@function", { fg = c.cyan, bold = true })
hi("@function.builtin", { fg = c.cyan })
hi("@keyword", { fg = c.green, bold = true })
hi("@keyword.function", { fg = c.green, bold = true })
hi("@keyword.return", { fg = c.green, bold = true })
hi("@conditional", { fg = c.green, bold = true })
hi("@repeat", { fg = c.green, bold = true })
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.green_soft })
hi("@parameter", { fg = c.fg })
hi("@type", { fg = c.cyan, bold = true })
hi("@type.builtin", { fg = c.cyan, bold = true })
hi("@namespace", { fg = c.cyan })
hi("@include", { fg = c.cyan })

-- Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.amber })
hi("DiagnosticInfo", { fg = c.cyan })
hi("DiagnosticHint", { fg = c.fg_dim })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.amber, undercurl = true })

-- Git
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.cyan })
hi("GitSignsDelete", { fg = c.red })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg })
hi("TelescopeBorder", { fg = c.border, bg = c.bg })
hi("TelescopeSelection", { fg = c.fg, bg = c.panel_dark })
hi("TelescopeMatching", { fg = c.green_soft, bold = true })

-- Bufferline
hi("BufferLineFill", { bg = c.bg_dark })
hi("BufferLineBackground", { fg = c.fg_dim, bg = c.bg_dark })
hi("BufferLineBufferSelected", { fg = c.cyan, bg = c.panel_dark, bold = true })

-- netrw
hi("netrwDir", { fg = c.cyan, bold = true })
hi("netrwExe", { fg = c.green, bold = true })
