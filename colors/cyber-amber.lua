-- Cyber Amber colorscheme
-- Readability-first neon amber style with strong contrast and poster accents.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "cyber-amber"
vim.o.background = "dark"

local function clamp(v, lo, hi)
  if v < lo then return lo end
  if v > hi then return hi end
  return v
end

local function hex_to_rgb(hex)
  local clean = (hex or ""):gsub("#", "")
  if #clean ~= 6 then
    return 255, 157, 0
  end
  return tonumber(clean:sub(1, 2), 16), tonumber(clean:sub(3, 4), 16), tonumber(clean:sub(5, 6), 16)
end

local function rgb_to_hex(r, g, b)
  return string.format(
    "#%02X%02X%02X",
    clamp(math.floor(r + 0.5), 0, 255),
    clamp(math.floor(g + 0.5), 0, 255),
    clamp(math.floor(b + 0.5), 0, 255)
  )
end

local function mix(hex_a, hex_b, ratio)
  local w = clamp(ratio or 0.5, 0, 1)
  local ra, ga, ba = hex_to_rgb(hex_a)
  local rb, gb, bb = hex_to_rgb(hex_b)
  return rgb_to_hex((ra * (1 - w)) + (rb * w), (ga * (1 - w)) + (gb * w), (ba * (1 - w)) + (bb * w))
end

local fill = vim.g.cyber_amber_fill or "#FF9D00"

local c = {
  fill = fill,
  fill_soft = mix(fill, "#FFF08A", 0.35),
  fill_deep = mix(fill, "#000000", 0.22),

  bg = "#120700",
  bg_dark = "#0B0400",
  bg_panel = "#1A0A00",
  bg_panel_hi = "#2A1200",

  fg = "#FFD45E",
  fg_soft = "#F5C24F",
  fg_dim = "#D79A31",
  fg_muted = "#98661B",
  border = "#6F3400",

  pop_yellow = "#E7D219",
  pop_red = "#FF3A00",
  pop_red_soft = "#FF5A2D",
  pop_cyan = "#5CDBFF",
  pop_green = "#95F76D",

  ink = "#1B0900",
  red = "#FF6E5C",
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

-- UI
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalNC", { fg = c.fg_soft, bg = c.bg_dark })
hi("NormalFloat", { fg = c.fg, bg = c.bg_panel })
hi("FloatBorder", { fg = c.border, bg = c.bg_panel })
hi("Cursor", { fg = c.ink, bg = c.pop_yellow })
hi("CursorLine", { bg = c.bg_panel })
hi("CursorColumn", { bg = c.bg_panel })
hi("ColorColumn", { bg = c.bg_panel })
hi("LineNr", { fg = c.fg_muted, bg = c.bg })
hi("CursorLineNr", { fg = c.pop_yellow, bg = c.bg_panel, bold = true })
hi("SignColumn", { fg = c.fg_dim, bg = c.bg })
hi("WinSeparator", { fg = c.border, bg = c.bg })
hi("VertSplit", { fg = c.border, bg = c.bg })
hi("Folded", { fg = c.fg_dim, bg = c.bg_dark })
hi("MatchParen", { fg = c.pop_yellow, bg = c.bg_panel_hi, bold = true })
hi("NonText", { fg = c.fg_muted })
hi("EndOfBuffer", { fg = c.bg_panel })

-- High-contrast blocks for active UI parts
hi("StatusLine", { fg = c.ink, bg = c.pop_yellow, bold = true })
hi("StatusLineNC", { fg = c.fg_dim, bg = c.bg_panel })
hi("TabLine", { fg = c.fg_dim, bg = c.bg_dark })
hi("TabLineSel", { fg = c.ink, bg = c.fill_soft, bold = true })
hi("TabLineFill", { bg = c.bg_dark })
hi("Pmenu", { fg = c.fg, bg = c.bg_panel })
hi("PmenuSel", { fg = c.ink, bg = c.pop_yellow, bold = true })
hi("PmenuSbar", { bg = c.bg_dark })
hi("PmenuThumb", { bg = c.border })

-- Visual mode must stay readable on bright blocks
hi("Visual", { fg = c.ink, bg = c.pop_yellow })
hi("Search", { fg = c.ink, bg = c.pop_yellow, bold = true })
hi("IncSearch", { fg = c.pop_yellow, bg = c.pop_red, bold = true })
hi("CurSearch", { fg = c.pop_yellow, bg = c.pop_red, bold = true })
hi("ErrorMsg", { fg = c.red, bold = true })
hi("WarningMsg", { fg = c.pop_yellow, bold = true })
hi("ModeMsg", { fg = c.pop_red_soft, bold = true })
hi("Title", { fg = c.pop_red_soft, bold = true })
hi("Directory", { fg = c.pop_cyan, bold = true })
hi("DiffAdd", { fg = c.pop_green, bg = mix(c.pop_green, "#000000", 0.86) })
hi("DiffChange", { fg = c.pop_cyan, bg = c.bg_panel })
hi("DiffDelete", { fg = c.red, bg = mix(c.red, "#000000", 0.88) })
hi("DiffText", { fg = c.pop_yellow, bg = c.pop_red, bold = true })
hi("SpellBad", { sp = c.red, undercurl = true })

-- Syntax
hi("Comment", { fg = c.fg_muted, italic = true })
hi("Constant", { fg = c.fill_soft })
hi("String", { fg = c.pop_yellow })
hi("Character", { fg = c.pop_yellow })
hi("Number", { fg = c.fill_soft })
hi("Boolean", { fg = c.fill_soft, bold = true })
hi("Float", { fg = c.fill_soft })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.pop_cyan, bold = true })
hi("Statement", { fg = c.pop_red, bold = true })
hi("Conditional", { fg = c.pop_red, bold = true })
hi("Repeat", { fg = c.pop_red, bold = true })
hi("Label", { fg = c.pop_yellow })
hi("Operator", { fg = c.fg_soft })
hi("Keyword", { fg = c.pop_red, bold = true })
hi("Exception", { fg = c.pop_red_soft, bold = true })
hi("PreProc", { fg = c.pop_cyan })
hi("Include", { fg = c.pop_cyan })
hi("Define", { fg = c.pop_cyan })
hi("Macro", { fg = c.pop_cyan })
hi("Type", { fg = c.pop_green, bold = true })
hi("StorageClass", { fg = c.pop_green, bold = true })
hi("Structure", { fg = c.pop_green })
hi("Typedef", { fg = c.pop_green })
hi("Special", { fg = c.fill_soft })
hi("SpecialChar", { fg = c.fill_soft })
hi("Tag", { fg = c.fill_soft })
hi("Delimiter", { fg = c.fg })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.ink, bg = c.pop_yellow, bold = true })

-- Treesitter
hi("@comment", { fg = c.fg_muted, italic = true })
hi("@punctuation", { fg = c.fg })
hi("@constant", { fg = c.fill_soft })
hi("@constant.builtin", { fg = c.fill_soft, bold = true })
hi("@string", { fg = c.pop_yellow })
hi("@string.escape", { fg = c.pop_red_soft })
hi("@number", { fg = c.fill_soft })
hi("@boolean", { fg = c.fill_soft, bold = true })
hi("@function", { fg = c.pop_cyan, bold = true })
hi("@function.builtin", { fg = c.pop_cyan })
hi("@keyword", { fg = c.pop_red, bold = true })
hi("@keyword.function", { fg = c.pop_red, bold = true })
hi("@keyword.return", { fg = c.pop_red, bold = true })
hi("@conditional", { fg = c.pop_red, bold = true })
hi("@repeat", { fg = c.pop_red, bold = true })
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.fill_soft })
hi("@parameter", { fg = c.fg })
hi("@type", { fg = c.pop_green })
hi("@type.builtin", { fg = c.pop_green })
hi("@namespace", { fg = c.pop_cyan })
hi("@include", { fg = c.pop_cyan })

-- Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.pop_yellow })
hi("DiagnosticInfo", { fg = c.pop_cyan })
hi("DiagnosticHint", { fg = c.fg_dim })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.pop_yellow, undercurl = true })

-- Git
hi("GitSignsAdd", { fg = c.pop_green })
hi("GitSignsChange", { fg = c.pop_cyan })
hi("GitSignsDelete", { fg = c.red })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg_panel })
hi("TelescopeBorder", { fg = c.border, bg = c.bg_panel })
hi("TelescopeSelection", { fg = c.fg, bg = c.bg_panel_hi })
hi("TelescopeMatching", { fg = c.pop_yellow, bold = true })

-- Bufferline
hi("BufferLineFill", { bg = c.bg_dark })
hi("BufferLineBackground", { fg = c.fg_dim, bg = c.bg_dark })
hi("BufferLineBufferSelected", { fg = c.ink, bg = c.pop_yellow, bold = true })

-- netrw
hi("netrwDir", { fg = c.pop_cyan, bold = true })
hi("netrwExe", { fg = c.pop_green, bold = true })
