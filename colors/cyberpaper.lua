-- Cyberpaper Colorscheme
-- Inspired by the provided reference: near-black UI + warm paper cards.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.g.colors_name = "cyberpaper"
vim.o.background = "dark"

local c = {
  bg = "#040404",          -- true background
  bg_alt = "#0b0b0b",      -- subtle section bg
  paper = "#eee5c2",       -- warm fill
  paper_dim = "#ddd4b3",   -- muted warm text
  ink = "#121212",         -- text on paper
  ink_soft = "#2a2a2a",    -- muted text on paper
  line = "#6a6658",        -- divider line
  comment = "#8b866f",     -- neutral muted comments
  visual = "#2a2a24",      -- visual selection on dark bg
  cursorline = "#111111",
  error = "#ff7373",
  warn = "#f2c572",
  info = "#c8bea0",
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

-- Core UI
hi("Normal", { fg = c.paper, bg = c.bg })
hi("NormalNC", { fg = c.paper_dim, bg = c.bg })
hi("NormalFloat", { fg = c.ink, bg = c.paper })
hi("FloatBorder", { fg = c.paper, bg = c.bg })
hi("Cursor", { fg = c.bg, bg = c.paper })
hi("CursorLine", { bg = c.cursorline })
hi("CursorColumn", { bg = c.cursorline })
hi("ColorColumn", { bg = c.bg_alt })
hi("LineNr", { fg = c.line, bg = c.bg })
hi("CursorLineNr", { fg = c.paper, bg = c.cursorline, bold = true })
hi("SignColumn", { fg = c.line, bg = c.bg })
hi("VertSplit", { fg = c.line, bg = c.bg })
hi("WinSeparator", { fg = c.line, bg = c.bg })
hi("StatusLine", { fg = c.ink, bg = c.paper, bold = true })
hi("StatusLineNC", { fg = c.paper_dim, bg = c.bg_alt })
hi("TabLine", { fg = c.paper_dim, bg = c.bg_alt })
hi("TabLineSel", { fg = c.ink, bg = c.paper, bold = true })
hi("TabLineFill", { bg = c.bg_alt })
hi("Pmenu", { fg = c.ink, bg = c.paper })
hi("PmenuSel", { fg = c.paper, bg = c.ink_soft, bold = true })
hi("PmenuSbar", { bg = c.bg_alt })
hi("PmenuThumb", { bg = c.line })
hi("Visual", { bg = c.visual })
hi("Search", { fg = c.bg, bg = c.paper, bold = true })
hi("IncSearch", { fg = c.bg, bg = c.paper, bold = true })
hi("CurSearch", { fg = c.bg, bg = c.paper, bold = true })
hi("NonText", { fg = c.line })
hi("EndOfBuffer", { fg = c.bg })
hi("Folded", { fg = c.paper_dim, bg = c.bg_alt })
hi("MatchParen", { fg = c.bg, bg = c.paper, bold = true })

-- Syntax (mostly monochrome + warm paper contrast)
hi("Comment", { fg = c.comment, italic = true })
hi("Constant", { fg = c.paper })
hi("String", { fg = c.paper_dim })
hi("Number", { fg = c.paper })
hi("Boolean", { fg = c.paper, bold = true })
hi("Identifier", { fg = c.paper })
hi("Function", { fg = c.paper, bold = true })
hi("Statement", { fg = c.paper, bold = true })
hi("Keyword", { fg = c.paper, bold = true })
hi("Type", { fg = c.paper })
hi("PreProc", { fg = c.paper_dim })
hi("Special", { fg = c.paper })
hi("Delimiter", { fg = c.paper_dim })
hi("Operator", { fg = c.paper_dim })
hi("Todo", { fg = c.bg, bg = c.paper, bold = true })

-- Treesitter coverage
hi("@comment", { fg = c.comment, italic = true })
hi("@string", { fg = c.paper_dim })
hi("@number", { fg = c.paper })
hi("@boolean", { fg = c.paper, bold = true })
hi("@function", { fg = c.paper, bold = true })
hi("@function.builtin", { fg = c.paper_dim, bold = true })
hi("@keyword", { fg = c.paper, bold = true })
hi("@keyword.function", { fg = c.paper, bold = true })
hi("@variable", { fg = c.paper })
hi("@variable.builtin", { fg = c.paper_dim })
hi("@type", { fg = c.paper })
hi("@namespace", { fg = c.paper_dim })
hi("@punctuation", { fg = c.paper_dim })

-- Diagnostics / diff
hi("ErrorMsg", { fg = c.error, bold = true })
hi("WarningMsg", { fg = c.warn, bold = true })
hi("DiagnosticError", { fg = c.error })
hi("DiagnosticWarn", { fg = c.warn })
hi("DiagnosticInfo", { fg = c.info })
hi("DiagnosticHint", { fg = c.comment })
hi("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.warn, undercurl = true })
hi("DiffAdd", { fg = c.paper, bg = "#0e120e" })
hi("DiffChange", { fg = c.paper, bg = "#111111" })
hi("DiffDelete", { fg = c.error, bg = "#120d0d" })
hi("DiffText", { fg = c.bg, bg = c.paper, bold = true })

-- Telescope / bufferline / netrw basics
hi("TelescopeNormal", { fg = c.ink, bg = c.paper })
hi("TelescopeBorder", { fg = c.paper, bg = c.bg })
hi("TelescopeSelection", { fg = c.paper, bg = c.ink_soft })
hi("TelescopeMatching", { fg = c.ink, bg = c.paper, bold = true })

hi("BufferLineFill", { bg = c.bg_alt })
hi("BufferLineBackground", { fg = c.paper_dim, bg = c.bg_alt })
hi("BufferLineBufferSelected", { fg = c.ink, bg = c.paper, bold = true })

hi("netrwDir", { fg = c.paper, bold = true })
hi("netrwExe", { fg = c.paper_dim })
