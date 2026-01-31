# Project Dossier

## .beads/.gitignore

Role: Patterns for Git ignore behavior; helpful for repo context.

```
# SQLite databases
*.db
*.db?*
*.db-journal
*.db-wal
*.db-shm

# Daemon runtime files
daemon.lock
daemon.log
daemon.pid
bd.sock
sync-state.json
last-touched

# Local version tracking (prevents upgrade notification spam after git ops)
.local_version

# Legacy database files
db.sqlite
bd.db

# Worktree redirect file (contains relative path to main repo's .beads/)
# Must not be committed as paths would be wrong in other clones
redirect

# Merge artifacts (temporary files from 3-way merge)
beads.base.jsonl
beads.base.meta.json
beads.left.jsonl
beads.left.meta.json
beads.right.jsonl
beads.right.meta.json

# Sync state (local-only, per-machine)
# These files are machine-specific and should not be shared across clones
.sync.lock
sync_base.jsonl
export-state/

# NOTE: Do NOT add negation patterns (e.g., !issues.jsonl) here.
# They would override fork protection in .git/info/exclude, allowing
# contributors to accidentally commit upstream issue databases.
# The JSONL files (issues.jsonl, interactions.jsonl) and config files
# are tracked by git by default since no pattern above ignores them.
```

## .beads/.local_version

Role: Project file included for full context.

```
0.49.2
```

## .beads/README.md

Role: Project overview, usage, and core context.

```markdown
# Beads - AI-Native Issue Tracking

Welcome to Beads! This repository uses **Beads** for issue tracking - a modern, AI-native tool designed to live directly in your codebase alongside your code.

## What is Beads?

Beads is issue tracking that lives in your repo, making it perfect for AI coding agents and developers who want their issues close to their code. No web UI required - everything works through the CLI and integrates seamlessly with git.

**Learn more:** [github.com/steveyegge/beads](https://github.com/steveyegge/beads)

## Quick Start

### Essential Commands

```bash
# Create new issues
bd create "Add user authentication"

# View all issues
bd list

# View issue details
bd show <issue-id>

# Update issue status
bd update <issue-id> --status in_progress
bd update <issue-id> --status done

# Sync with git remote
bd sync
```

### Working with Issues

Issues in Beads are:
- **Git-native**: Stored in `.beads/issues.jsonl` and synced like code
- **AI-friendly**: CLI-first design works perfectly with AI coding agents
- **Branch-aware**: Issues can follow your branch workflow
- **Always in sync**: Auto-syncs with your commits

## Why Beads?

✨ **AI-Native Design**
- Built specifically for AI-assisted development workflows
- CLI-first interface works seamlessly with AI coding agents
- No context switching to web UIs

🚀 **Developer Focused**
- Issues live in your repo, right next to your code
- Works offline, syncs when you push
- Fast, lightweight, and stays out of your way

🔧 **Git Integration**
- Automatic sync with git commits
- Branch-aware issue tracking
- Intelligent JSONL merge resolution

## Get Started with Beads

Try Beads in your own projects:

```bash
# Install Beads
curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

# Initialize in your repo
bd init

# Create your first issue
bd create "Try out Beads"
```

## Learn More

- **Documentation**: [github.com/steveyegge/beads/docs](https://github.com/steveyegge/beads/tree/main/docs)
- **Quick Start Guide**: Run `bd quickstart`
- **Examples**: [github.com/steveyegge/beads/examples](https://github.com/steveyegge/beads/tree/main/examples)

---

*Beads: Issue tracking that moves at the speed of thought* ⚡
```

## .beads/beads.db-wal

Role: Project file included for full context.

```

```

## .beads/config.yaml

Role: Configuration affecting build/runtime behavior.

```yaml
# Beads Configuration File
# This file configures default behavior for all bd commands in this repository
# All settings can also be set via environment variables (BD_* prefix)
# or overridden with command-line flags

# Issue prefix for this repository (used by bd init)
# If not set, bd init will auto-detect from directory name
# Example: issue-prefix: "myproject" creates issues like "myproject-1", "myproject-2", etc.
# issue-prefix: ""

# Use no-db mode: load from JSONL, no SQLite, write back after each command
# When true, bd will use .beads/issues.jsonl as the source of truth
# instead of SQLite database
# no-db: false

# Disable daemon for RPC communication (forces direct database access)
# no-daemon: false

# Disable auto-flush of database to JSONL after mutations
# no-auto-flush: false

# Disable auto-import from JSONL when it's newer than database
# no-auto-import: false

# Enable JSON output by default
# json: false

# Default actor for audit trails (overridden by BD_ACTOR or --actor)
# actor: ""

# Path to database (overridden by BEADS_DB or --db)
# db: ""

# Auto-start daemon if not running (can also use BEADS_AUTO_START_DAEMON)
# auto-start-daemon: true

# Debounce interval for auto-flush (can also use BEADS_FLUSH_DEBOUNCE)
# flush-debounce: "5s"

# Git branch for beads commits (bd sync will commit to this branch)
# IMPORTANT: Set this for team projects so all clones use the same sync branch.
# This setting persists across clones (unlike database config which is gitignored).
# Can also use BEADS_SYNC_BRANCH env var for local override.
# If not set, bd sync will require you to run 'bd config set sync.branch <branch>'.
sync-branch: "beads-sync"

# Multi-repo configuration (experimental - bd-307)
# Allows hydrating from multiple repositories and routing writes to the correct JSONL
# repos:
#   primary: "."  # Primary repo (where this database lives)
#   additional:   # Additional repos to hydrate from (read-only)
#     - ~/beads-planning  # Personal planning repo
#     - ~/work-planning   # Work planning repo

# Integration settings (access with 'bd config get/set')
# These are stored in the database, not in this file:
# - jira.url
# - jira.project
# - linear.url
# - linear.api-key
# - github.org
# - github.repo
```

## .beads/daemon.log

Role: Project file included for full context.

```
time=2026-01-31T17:41:36.044+03:00 level=INFO msg="Daemon started (interval: %v, auto-commit: %v, auto-push: %v)" !BADKEY=5s !BADKEY=false !BADKEY=false
time=2026-01-31T17:41:36.045+03:00 level=INFO msg="using database" path=/Users/numero_quadro/.config/nvim/.beads/beads.db
time=2026-01-31T17:41:36.063+03:00 level=INFO msg="database opened" path=/Users/numero_quadro/.config/nvim/.beads/beads.db backend=sqlite freshness_checking=true
time=2026-01-31T17:41:36.063+03:00 level=INFO msg="upgrading .beads/.gitignore"
time=2026-01-31T17:41:36.063+03:00 level=WARN msg="failed to upgrade .gitignore" error="open .beads/.gitignore: no such file or directory"
time=2026-01-31T17:41:36.067+03:00 level=INFO msg="Repository fingerprint validated: %s" !BADKEY=90d13b86
time=2026-01-31T17:41:36.067+03:00 level=INFO msg="starting RPC server" socket=/Users/numero_quadro/.config/nvim/.beads/bd.sock
time=2026-01-31T17:41:36.067+03:00 level=INFO msg="RPC server ready (socket listening)"
time=2026-01-31T17:41:36.073+03:00 level=INFO msg="registered in global registry"
time=2026-01-31T17:41:36.073+03:00 level=INFO msg="Starting %s..." !BADKEY="sync cycle"
time=2026-01-31T17:41:36.073+03:00 level=INFO msg="Exported to JSONL"
time=2026-01-31T17:41:38.373+03:00 level=INFO msg="Pull failed: %v" !BADKEY="git pull failed: exit status 128\nFrom github.com:NumeroQuadro/goofy-ahh-neovim-config\n * branch            main       -> FETCH_HEAD\nwarning: fetch updated the current branch head.\nfast-forwarding your working tree from\ncommit 548cbed070cec7a701ab51ffa6ff3654269181be.\nerror: The following untracked working tree files would be overwritten by merge:\n\t.beads/issues.jsonl\nPlease move or remove them before you merge.\nAborting\nfatal: Cannot fast-forward your working tree.\nAfter making sure that you saved anything precious from\n$ git diff 548cbed070cec7a701ab51ffa6ff3654269181be\noutput, run\n$ git reset --hard\nto recover.\n"
time=2026-01-31T17:41:38.373+03:00 level=INFO msg="monitoring parent process" pid=0
time=2026-01-31T17:41:38.373+03:00 level=INFO msg="using event-driven mode"
time=2026-01-31T17:41:38.375+03:00 level=INFO msg="Auto-pull disabled: use 'git pull' manually to sync remote changes"
time=2026-01-31T17:41:44.780+03:00 level=INFO msg="JSONL removed/renamed, re-establishing watch"
time=2026-01-31T17:41:44.831+03:00 level=INFO msg="Successfully re-established JSONL watch after %v" !BADKEY=50ms
time=2026-01-31T17:41:44.831+03:00 level=INFO msg="Git HEAD change detected: %s" !BADKEY=/Users/numero_quadro/.config/nvim/.git/HEAD
time=2026-01-31T17:41:44.832+03:00 level=INFO msg="JSONL file created: %s" !BADKEY=/Users/numero_quadro/.config/nvim/.beads/issues.jsonl
time=2026-01-31T17:41:45.833+03:00 level=INFO msg="Import triggered by file change"
time=2026-01-31T17:41:45.835+03:00 level=INFO msg="Starting %s..." !BADKEY=auto-import
time=2026-01-31T17:41:45.836+03:00 level=INFO msg="Skipping %s: JSONL content unchanged" !BADKEY=auto-import
time=2026-01-31T17:42:36.555+03:00 level=INFO msg="Received signal %v, shutting down..." !BADKEY=terminated
time=2026-01-31T17:42:44.308+03:00 level=INFO msg="Daemon started (interval: %v, auto-commit: %v, auto-push: %v)" !BADKEY=5s !BADKEY=false !BADKEY=false
time=2026-01-31T17:42:44.308+03:00 level=INFO msg="using database" path=/Users/numero_quadro/.config/nvim/.beads/beads.db
time=2026-01-31T17:42:44.546+03:00 level=INFO msg="database opened" path=/Users/numero_quadro/.config/nvim/.beads/beads.db backend=sqlite freshness_checking=true
time=2026-01-31T17:42:44.546+03:00 level=INFO msg="upgrading .beads/.gitignore"
time=2026-01-31T17:42:44.546+03:00 level=WARN msg="failed to upgrade .gitignore" error="open .beads/.gitignore: no such file or directory"
time=2026-01-31T17:42:44.551+03:00 level=INFO msg="Repository fingerprint validated: %s" !BADKEY=90d13b86
time=2026-01-31T17:42:44.551+03:00 level=WARN msg="database schema version mismatch" db_version=0.49.1 daemon_version=0.49.2
time=2026-01-31T17:42:44.551+03:00 level=INFO msg="auto-upgrading database to daemon version"
time=2026-01-31T17:42:44.551+03:00 level=INFO msg="database version updated" version=0.49.2
time=2026-01-31T17:42:44.551+03:00 level=INFO msg="starting RPC server" socket=/Users/numero_quadro/.config/nvim/.beads/bd.sock
time=2026-01-31T17:42:44.551+03:00 level=INFO msg="RPC server ready (socket listening)"
time=2026-01-31T17:42:44.557+03:00 level=INFO msg="registered in global registry"
time=2026-01-31T17:42:44.557+03:00 level=INFO msg="Starting %s..." !BADKEY="sync cycle"
time=2026-01-31T17:42:44.557+03:00 level=INFO msg="Exported to JSONL"
time=2026-01-31T17:42:46.734+03:00 level=INFO msg="Pulled from remote"
time=2026-01-31T17:42:46.750+03:00 level=INFO msg="Imported from JSONL"
time=2026-01-31T17:42:46.765+03:00 level=INFO msg="Sync cycle complete"
time=2026-01-31T17:42:46.765+03:00 level=INFO msg="monitoring parent process" pid=0
time=2026-01-31T17:42:46.765+03:00 level=INFO msg="using event-driven mode"
time=2026-01-31T17:42:46.766+03:00 level=INFO msg="Auto-pull disabled: use 'git pull' manually to sync remote changes"
time=2026-01-31T17:42:49.399+03:00 level=INFO msg="JSONL removed/renamed, re-establishing watch"
time=2026-01-31T17:42:49.450+03:00 level=INFO msg="Successfully re-established JSONL watch after %v" !BADKEY=50ms
time=2026-01-31T17:42:49.450+03:00 level=INFO msg="JSONL file created: %s" !BADKEY=/Users/numero_quadro/.config/nvim/.beads/issues.jsonl
time=2026-01-31T17:42:50.451+03:00 level=INFO msg="Import triggered by file change"
time=2026-01-31T17:42:50.470+03:00 level=INFO msg="Starting %s..." !BADKEY=auto-import
time=2026-01-31T17:42:50.471+03:00 level=INFO msg="Skipping %s: JSONL content unchanged" !BADKEY=auto-import
time=2026-01-31T17:43:59.933+03:00 level=INFO msg="JSONL removed/renamed, re-establishing watch"
time=2026-01-31T17:43:59.984+03:00 level=INFO msg="Successfully re-established JSONL watch after %v" !BADKEY=50ms
time=2026-01-31T17:43:59.984+03:00 level=INFO msg="JSONL file created: %s" !BADKEY=/Users/numero_quadro/.config/nvim/.beads/issues.jsonl
time=2026-01-31T17:44:00.985+03:00 level=INFO msg="Import triggered by file change"
time=2026-01-31T17:44:01.005+03:00 level=INFO msg="Starting %s..." !BADKEY=auto-import
time=2026-01-31T17:44:01.005+03:00 level=INFO msg="Skipping %s: JSONL content unchanged" !BADKEY=auto-import
```

## .beads/daemon.pid

Role: Project file included for full context.

```
14092
```

## .beads/export-state/d34bde99e0f9dd87.json

Role: Project file included for full context.

```json
{
  "worktree_root": "/Users/numero_quadro/.config/nvim/.git/beads-worktrees/beads-sync",
  "last_export_commit": "6702adc65746e697a3427696f263f4d22005b88f",
  "last_export_time": "2026-01-31T17:42:47.271465+03:00",
  "jsonl_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
}
```

## .beads/interactions.jsonl

Role: Project file included for full context.

```

```

## .beads/issues.jsonl

Role: Project file included for full context.

```

```

## .beads/metadata.json

Role: Project file included for full context.

```json
{
  "database": "beads.db",
  "jsonl_export": "issues.jsonl"
}
```

## .gitattributes

Role: Project file included for full context.

```

# Use bd merge for beads JSONL files
.beads/issues.jsonl merge=beads
```

## .gitignore

Role: Patterns for Git ignore behavior; helpful for repo context.

```
lazy-lock.json
GEMINI.md
.DS_Store
```

## .luarc.json

Role: Project file included for full context.

```json
{
    "diagnostics.globals": [
        "vim"
    ]
}
```

## AGENTS.md

Role: Documentation or project narrative context.

```markdown
# Agent Instructions

This repository contains a Neovim configuration.

- Read `init.lua` and `lua/vim-options.lua` before making changes.
- Plugin configuration lives in `lua/plugins/`.
- Keep `README.md` and `NOTES.md` aligned with the actual config and keymaps.
- Avoid documenting helper tooling that is unrelated to the Neovim config.
```

## GEMINI.md

Role: Documentation or project narrative context.

```markdown
- This directory is the active Neovim config loaded from `init.lua`. Scan it before answering questions.
- Edit only this config when making changes.
- Before adding a feature, search for similar existing functionality and report overlaps.
- If something is missing, look up a current approach and suggest concrete changes.
- Keep `README.md` and `NOTES.md` aligned with the actual config.
- Do not document helper tooling that is unrelated to the Neovim config.
```

## Makefile.go-cover

Role: Project file included for full context.

```
PKG := ./...
COVER_FILE := coverage.out
COVER_THRESH ?= 60.0

.PHONY: test cover cover.html cover.nvm cover.check

test:
	go test $(PKG)

# Generate coverage profile
cover:
	go test $(PKG) -coverprofile=$(COVER_FILE)

# Open HTML coverage report (fallback when Neovim coverage is unavailable)
cover.html: cover
	go tool cover -html=$(COVER_FILE)

# Open Neovim and show inline coverage (requires go.nvim or vim-go)
cover.nvm: cover
	@# Detect if :GoCoverage command exists; if so, use it. Otherwise open HTML fallback.
	@if nvim --headless "+silent! echo exists(':GoCoverage')" +q 2>/dev/null | grep -q "1"; then \
		nvim -c "GoCoverage" . ; \
	else \
		echo "Neovim coverage plugin not found; opening HTML report..."; \
		go tool cover -html=$(COVER_FILE); \
	fi

# Fail if coverage below threshold
cover.check: cover
	@total=$$(go tool cover -func=$(COVER_FILE) | awk '/total:/ {print $$3}' | tr -d '%'); \
	ok=$$(awk -v t=$(COVER_THRESH) -v c=$$total 'BEGIN{print (c+0 >= t+0)?1:0}'); \
	if [ $$ok -ne 1 ]; then \
		echo "Coverage $$total% < threshold $(COVER_THRESH)%"; exit 1; \
	else echo "Coverage $$total% ≥ $(COVER_THRESH)%"; fi
```

## NOTES.md

Role: Documentation or project narrative context.

```markdown
Neovim Config — Notes

Scope
- This repo is the active Neovim config loaded by `init.lua`.
- Documentation focuses on config behavior, not helper tooling.

Known mapping overlaps
- `<leader>fe` and `-` are set for netrw in `lua/vim-options.lua` but are later overwritten by Telescope file_browser mappings in `lua/plugins/telescope.lua`.
- `<leader>gb` is set for the Gruvbox background picker but is later overwritten by gitsigns blame in `lua/plugins/gitsigns.lua`.
- `<leader>gs` is Telescope git status by default, but go.nvim remaps it to `:GoCoverage` in Go buffers.

Formatting behavior
- SQL format-on-save uses `conform.nvim` (`sql_formatter`). Toggle with `:SqlFormatOnSave*` commands.
- Kotlin format-on-save uses `conform.nvim` (`ktlint`).
- Go formatting is triggered when you type `:w` and prefers LSP formatting, then falls back to conform or go.nvim commands.

Diagnostics prefixes in Telescope
- Telescope file_browser shows diagnostic counts only for already-open buffers (see `lua/util/diag_prefix.lua`).

LSP setup
- LSP autostart is defined in both `lua/lsp-core.lua` and `lua/plugins/lsp-config.lua`. Both use `vim.lsp.start` and check for existing clients by name, so they do not double-attach, but the configuration is duplicated.
- Mason ensures several servers are installed; only the servers defined in the LSP config files are actually started.
```

## README.md

Role: Project overview, usage, and core context.

```markdown
# Neovim Config

Overview
- This repository is the active Neovim configuration.
- Entry point is `init.lua`, which bootstraps lazy.nvim, loads options/keymaps, then loads plugins.

Structure
- `init.lua` bootstraps lazy.nvim, adds Homebrew paths, loads `lua/vim-options.lua`, applies the colorscheme, and enables LSP core.
- `lua/vim-options.lua` holds editor options, custom keymaps, netrw tweaks, terminal behavior, and formatting hooks.
- `lua/lsp-core.lua` defines LSP autostart via `vim.lsp.start`, root detection, and LSP keymaps.
- `lua/lsp-noise.lua` filters noisy LSP popups (especially from gopls).
- `lua/util/diag_prefix.lua` generates diagnostic prefixes for Telescope file_browser entries.
- `lua/plugins/*.lua` contains lazy.nvim plugin specs and per-plugin configuration.
- `colors/retro-terminal.lua` is a local colorscheme.
- `lazy-lock.json` pins plugin versions.
- `Makefile.go-cover` provides optional Go coverage helpers.

Features
- Plugin manager via lazy.nvim with a lockfile.
- LSP autostart for Go, Lua, Python, C/C++, Bash, JSON, YAML, CSS, HTML, Vimscript, Java, and Kotlin.
- Completion with nvim-cmp + LuaSnip, plus autopairs integration.
- Search and navigation with Telescope and file_browser; Pounce for jump navigation.
- Git integrations with gitsigns and Diffview, plus Telescope git pickers.
- Formatting hooks for SQL and Kotlin, plus Go formatting on `:w`.
- UI setup with theme switching, bufferline tabs, lualine statusline, and neoscroll.
- Markdown preview auto-starts for markdown buffers.
- Coverage overlays via nvim-coverage and `coverage.out`.

Keymaps (custom)
- `jk` in insert mode exits to normal mode.
- `H` and `L` jump to the start and end of line.
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` move window focus.
- `<leader>v` and `<leader>s` split windows.
- Tabs: `<leader>tn` new, `<leader>tx` close, `<leader>to` close others, `<leader>ts` split, `<leader>tt` duplicate, `]t` and `[t` next and previous.
- Buffers: `]b` and `[b` next and previous, `<leader>bd` delete, `<leader>ba` delete all, `<leader>bo` delete others.
- Files: `<leader>nf` new file, `<leader>nd` new directory, `<leader>rf` rename file, `<leader>df` delete file, `<leader>yp` copy full path, `<leader>y` yank to system clipboard.
- Telescope: `<C-p>` find files, `<leader>fg` live grep, `<leader>ff` filtered grep, `<leader>fF` literal grep, `<leader>fb` buffers, `<leader>fr` recent files, `<leader>ft` todos, `<leader>fe` file browser at project root, `-` file browser at current file directory.
- Diagnostics: `<leader>d` all, `<leader>de` errors, `<leader>dw` warnings, `<leader>df` current file, `<leader>e` float or current-file list.
- LSP: `gd` definition, `gT` type definition, `gi` implementation, `gr` references, `K` hover, `<leader>rn` rename, `<leader>ca` code action, `[d` and `]d` prev and next diagnostic, `<C-k>` signature help in insert mode.
- Git: `<leader>gb` blame line, `<leader>hr` reset hunk, `<leader>gd` Diffview open, `<leader>gq` Diffview close, `<leader>gh` file history, `<leader>gH` repo history, `<leader>gc` git commits, `<leader>gC` buffer commits, `<leader>gs` git status in non-Go buffers.
- Go: `<leader>gs` GoCoverage and `<leader>gS` GoCoverageClear in Go buffers.
- Replace: `<leader>sp` project replace, `<leader>sf` file replace, `<leader>sw` search word (normal or visual).
- Coverage: `<leader>cl` load, `<leader>cs` show, `<leader>ch` hide, `<leader>cc` clear.
- Pounce: `s` and `S` in normal or operator-pending, `<C-s>` in insert.
- UI toggles: `<leader>m` mouse toggle, `<leader>th` theme picker, `<leader>gb` Gruvbox background picker (see NOTES for overlap).
- Reload: `<leader>R` reload files changed on disk.

Commands and toggles
- Mouse: `:MouseOn`, `:MouseOff`, `:MouseToggle`, `:MouseOffTemp [ms]`
- Scroll wheel cursor mode: `:ScrollCursorOn`, `:ScrollCursorOff`, `:ScrollCursorToggle`
- SQL format toggles: `:SqlFormatOnSaveEnable`, `:SqlFormatOnSaveDisable`, `:SqlFormatOnSaveToggle`, and global variants.

External tools and dependencies
- ripgrep (`rg`) is used by Telescope for file search and grep.
- LSP servers are started via `vim.lsp.start` and installed via Mason where available.
- SQL formatting expects a `sql_formatter` binary.
- Kotlin formatting expects `ktlint`.
- Go formatting uses gopls or go.nvim tooling (`goimports`, `gofmt`) when available.

Notes
- `NOTES.md` documents keymap overlaps and other configuration caveats.
```

## colors/retro-terminal.lua

Role: Project file included for full context.

```
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
```

## init.lua

Role: Project file included for full context.

```
-- Bootstrap lazy.nvim, a modern plugin manager for Neovim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- If lazy.nvim is not installed, clone it from GitHub
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Ensure common Homebrew paths are available for Neovim (e.g., im-select)
do
  local candidates = { "/opt/homebrew/bin", "/usr/local/bin" }
  for _, p in ipairs(candidates) do
    if vim.fn.isdirectory(p) == 1 and not string.find(vim.env.PATH or '', vim.pesc(p)) then
      vim.env.PATH = p .. ":" .. (vim.env.PATH or '')
    end
  end
end

-- Load core Neovim options and keymaps from a separate file
require("vim-options")

-- Configure lazy.nvim to load all plugins from the 'plugins' directory
require("lazy").setup({
  spec = "plugins",             -- Directory or module where plugin specs are defined
  change_detection = {
    notify = false,             -- Disable notifications when plugins are reloaded
  },
  -- Disable LuaRocks support to silence warnings (no plugins require it)
  rocks = { enabled = false },
})

-- Apply default colorscheme after plugins load
if not vim.g.colorscheme or vim.g.colorscheme == "" then
  vim.g.colorscheme = "gruvbox"
end
pcall(vim.cmd.colorscheme, vim.g.colorscheme)

-- Quiet noisy LSP popups from gopls (e.g., InlayHint metadata warnings)
pcall(require, "lsp-noise")

-- Core LSP bootstrap (uses vim.lsp.start, no lspconfig framework)
pcall(require, "lsp-core")
```

## lazy-lock.json

Role: Project file included for full context.

```json
{
  "2077.nvim": { "branch": "master", "commit": "ac84f753d225649c95ea86b0157f982c8f694237" },
  "LuaSnip": { "branch": "master", "commit": "73813308abc2eaeff2bc0d3f2f79270c491be9d7" },
  "black": { "branch": "main", "commit": "6abb865eebab75ddab0e22510868f35ccafdd14d" },
  "bufdelete.nvim": { "branch": "master", "commit": "f6bcea78afb3060b198125256f897040538bcb81" },
  "bufferline.nvim": { "branch": "main", "commit": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" },
  "catppuccin": { "branch": "main", "commit": "da33755d00e09bff2473978910168ff9ea5dc453" },
  "cmp-buffer": { "branch": "main", "commit": "b74fab3656eea9de20a9b8116afa3cfc4ec09657" },
  "cmp-nvim-lsp": { "branch": "main", "commit": "cbc7b02bb99fae35cb42f514762b89b5126651ef" },
  "cmp-path": { "branch": "main", "commit": "c642487086dbd9a93160e1679a1327be111cbc25" },
  "cmp_luasnip": { "branch": "master", "commit": "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
  "conform.nvim": { "branch": "master", "commit": "cde4da5c1083d3527776fee69536107d98dae6c9" },
  "cyberdream.nvim": { "branch": "main", "commit": "a956559cda735fbc9f0b39541529386322afaedd" },
  "diffview.nvim": { "branch": "main", "commit": "4516612fe98ff56ae0415a259ff6361a89419b0a" },
  "gitsigns.nvim": { "branch": "main", "commit": "20ad4419564d6e22b189f6738116b38871082332" },
  "go.nvim": { "branch": "master", "commit": "81bb94c1d21648245eb14c69461f5c7f8c705752" },
  "gruvbox.nvim": { "branch": "main", "commit": "5e0a460d8e0f7f669c158dedd5f9ae2bcac31437" },
  "guihua.lua": { "branch": "master", "commit": "ef44ba40f12e56c1c9fa45967f2b4d142e4b97a0" },
  "lazy.nvim": { "branch": "main", "commit": "85c7ff3711b730b4030d03144f6db6375044ae82" },
  "lualine.nvim": { "branch": "master", "commit": "3946f0122255bc377d14a59b27b609fb3ab25768" },
  "mason-lspconfig.nvim": { "branch": "main", "commit": "b1d9a914b02ba5660f1e272a03314b31d4576fe2" },
  "mason.nvim": { "branch": "main", "commit": "57e5a8addb8c71fb063ee4acda466c7cf6ad2800" },
  "mdpreview.nvim": { "branch": "master", "commit": "c0996795060dfd4c160ee20a173767706763e249" },
  "monochrome": { "branch": "main", "commit": "c4f18812bbdbe640ffddf69e0c5734ec87d6b5e7" },
  "neoscroll.nvim": { "branch": "master", "commit": "f957373912e88579e26fdaea4735450ff2ef5c9c" },
  "nvim-autopairs": { "branch": "master", "commit": "7a2c97cccd60abc559344042fefb1d5a85b3e33b" },
  "nvim-cmp": { "branch": "main", "commit": "d78fb3b64eedb701c9939f97361c06483af575e0" },
  "nvim-coverage": { "branch": "main", "commit": "a939e425e363319d952a6c35fb3f38b34041ded2" },
  "nvim-cursorline": { "branch": "main", "commit": "804f0023692653b2b2368462d67d2a87056947f9" },
  "nvim-lspconfig": { "branch": "master", "commit": "c6f05c0900144f027a8a0332566878e398d457b5" },
  "nvim-spectre": { "branch": "master", "commit": "72f56f7585903cd7bf92c665351aa585e150af0f" },
  "nvim-treesitter": { "branch": "master", "commit": "42fc28ba918343ebfd5565147a42a26580579482" },
  "nvim-treesitter-context": { "branch": "master", "commit": "660861b1849256398f70450afdf93908d28dc945" },
  "nvim-treesitter-textobjects": { "branch": "master", "commit": "5ca4aaa6efdcc59be46b95a3e876300cfead05ef" },
  "nvim-web-devicons": { "branch": "master", "commit": "8dcb311b0c92d460fac00eac706abd43d94d68af" },
  "plenary.nvim": { "branch": "master", "commit": "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
  "pounce.nvim": { "branch": "master", "commit": "2e36399ac09b517770c459f1a123e6b4b4c1c171" },
  "telescope-file-browser.nvim": { "branch": "master", "commit": "3610dc7dc91f06aa98b11dca5cc30dfa98626b7e" },
  "telescope.nvim": { "branch": "master", "commit": "3a12a853ebf21ec1cce9a92290e3013f8ae75f02" },
  "todo-comments.nvim": { "branch": "main", "commit": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" }
}
```

## lua/.luarc.json

Role: Project file included for full context.

```json
{
    "diagnostics.globals": [
        "vim"
    ]
}
```

## lua/lsp-core.lua

Role: Project file included for full context.

```
-- Core LSP bootstrap without nvim-lspconfig framework

-- UI: signature help floating window style
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded",
    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
  }
)

-- Root detection using core vim.fs
local function compute_root(patterns, buf)
  local path = vim.api.nvim_buf_get_name(buf or 0)
  local start_dir = (path ~= '' and vim.fs.dirname(path)) or (vim.uv and vim.uv.cwd()) or vim.loop.cwd()
  local found = vim.fs.find(patterns, { upward = true, path = start_dir })[1]
  return found and vim.fs.dirname(found) or start_dir
end

-- Deduplicate LSP locations by uri + start position
local function dedupe_locations(locations)
  if not locations or vim.tbl_isempty(locations) then return {} end
  local seen, unique = {}, {}
  for _, loc in ipairs(locations) do
    local uri = loc.uri or loc.targetUri or ""
    local range = loc.range or loc.targetSelectionRange or loc.targetRange or { start = { line = -1, character = -1 } }
    local s = range.start or { line = -1, character = -1 }
    local key = string.format("%s:%d:%d", uri, s.line or -1, s.character or -1)
    if not seen[key] then
      seen[key] = true
      table.insert(unique, loc)
    end
  end
  return unique
end

-- Present a list of locations in Telescope if available, otherwise quickfix
local function present_locations_with_telescope(locs, title)
  local ok, pickers = pcall(require, 'telescope.pickers')
  if not ok then
    vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(locs, 'utf-8'))
    vim.cmd('copen')
    return
  end
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local make_entry = require('telescope.make_entry')
  local items = vim.lsp.util.locations_to_items(locs, 'utf-8')
  pickers.new({}, {
    prompt_title = title or 'LSP Results',
    finder = finders.new_table({ results = items, entry_maker = make_entry.gen_from_quickfix() }),
    sorter = conf.generic_sorter({}),
    previewer = conf.qflist_previewer({}),
  }):find()
end

-- Compatibility helper for opening LSP locations without deprecated APIs
local function open_lsp_location(location)
  local util = vim.lsp.util
  if util and util.show_document then
    if location.targetUri then
      util.show_document({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
    else
      util.show_document(location, "utf-8")
    end
  else
    if location.targetUri then
      util.jump_to_location({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
    else
      util.jump_to_location(location, "utf-8")
    end
  end
end

local function jump_to_first_location_or_picker(result, picker_name)
  if not result or vim.tbl_isempty(result) then return false end
  local locations = result
  if result.result then locations = result.result end
  if not locations or vim.tbl_isempty(locations) then return false end
  locations = dedupe_locations(locations)
  if #locations == 1 then
    open_lsp_location(locations[1])
  else
    present_locations_with_telescope(locations, picker_name)
  end
  return true
end

-- Capabilities
local function make_capabilities()
  local ok, cmp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    return cmp.default_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end

local capabilities = make_capabilities()

-- on_attach with basic keymaps
local on_attach = function(client, bufnr)
  local buf_set_keymap = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  if client:supports_method("textDocument/inlayHint") then
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name:sub(-3) == ".go" then
      pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
    end
  end
  if client:supports_method("textDocument/codeLens") then
    pcall(vim.lsp.codelens.refresh)
  end
  local goto_definition_smart = function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, def)
      local ok = jump_to_first_location_or_picker(def, 'Definitions')
      if not ok then return end
    end)
  end
  buf_set_keymap('n', 'gd', goto_definition_smart, { desc = 'LSP Definition (smart)' })
  buf_set_keymap('n', 'gT', function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(_, tdef)
      jump_to_first_location_or_picker(tdef, 'Type Definitions')
    end)
  end, { desc = 'LSP Type Definition (deduped)' })
  buf_set_keymap('n', 'gi', function()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then builtin.lsp_implementations() else vim.lsp.buf.implementation() end
  end, { desc = 'LSP Implementation' })
  buf_set_keymap('n', 'gr', function()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then builtin.lsp_references() else vim.lsp.buf.references() end
  end, { desc = 'LSP References' })
  buf_set_keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
  buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
  buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
  buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
  buf_set_keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
  buf_set_keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  buf_set_keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
  buf_set_keymap('n', '<leader>e', function()
    local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
    if diags and #diags > 0 then
      vim.diagnostic.open_float(nil, { scope = 'line', focus = false })
      return
    end
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
      builtin.diagnostics({ bufnr = 0, prompt_title = 'Current File Diagnostics' })
    else
      vim.diagnostic.setloclist({ open = true })
    end
  end, { desc = 'Diagnostics: float/peek', nowait = true })
end

-- Server definitions (no lspconfig)
local servers = {
  gopls = {
    cmd = { "gopls" },
    -- Constrain gopls memory usage and scanning scope
    cmd_env = { GOMEMLIMIT = "2GiB" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    -- Avoid using .git as root to prevent scanning huge monorepos
    root_patterns = { "go.work", "go.mod" },
    settings = {
      gopls = {
        -- Keep features useful, but avoid heavy background work
        usePlaceholders = true,
        staticcheck = false,
        completeUnimported = false,
        completionBudget = "100ms",
        matcher = "CaseSensitive",
        expandWorkspaceToModule = true,
        directoryFilters = {
          "-.git",
          "-node_modules",
          "-vendor",
          "-bazel-bin",
          "-bazel-out",
          "-bazel-testlogs",
          "-build",
          "-bin",
          "-out",
          "-target",
          "-.cache",
        },
        analyses = { unusedparams = true, shadow = true },
        codelenses = { test = true, tidy = true, upgrade_dependency = true },
        hints = { assignVariableTypes = true, parameterNames = true, rangeVariableTypes = true },
      },
    },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_patterns = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = { globals = { "vim" } },
      },
    },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_patterns = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  },
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_patterns = { "compile_commands.json", "CMakeLists.txt", ".git" },
  },
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_patterns = { ".git" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_patterns = { ".git" },
  },
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_patterns = { ".git" },
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = { format = { enable = true } },
    },
  },
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_patterns = { ".git" },
  },
  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_patterns = { ".git" },
  },
  vimls = {
    cmd = { "vim-language-server", "--stdio" },
    filetypes = { "vim" },
    root_patterns = { ".git" },
  },
  jdtls = {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_patterns = { "gradlew", "mvnw", ".git", "build.gradle", "build.gradle.kts", "pom.xml", "settings.gradle", "settings.gradle.kts" },
    single_file_support = true,
  },
  kotlin_language_server = {
    cmd = { "kotlin-language-server" },
    filetypes = { "kotlin" },
    root_patterns = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", ".git" },
    settings = { kotlin = { compiler = { jvm = { target = "17" } } } },
  },
}

-- Autostart on filetype
local group = vim.api.nvim_create_augroup("UserLspAutoStart", { clear = true })
for name, cfg in pairs(servers) do
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = cfg.filetypes or {},
    callback = function(args)
      local root_dir = compute_root(cfg.root_patterns or { ".git" }, args.buf)
      -- For Go, avoid starting gopls unless within a module/workspace
      if name == 'gopls' then
        local has_go_mod = (vim.uv or vim.loop).fs_stat(root_dir .. "/go.mod") ~= nil
        local has_go_work = (vim.uv or vim.loop).fs_stat(root_dir .. "/go.work") ~= nil
        if not (has_go_mod or has_go_work) then
          return
        end
      end
      -- Avoid starting if a matching client is already attached
      local existing = vim.lsp.get_clients({ bufnr = args.buf, name = name })
      if existing and #existing > 0 then return end
      vim.lsp.start({
        name = name,
        cmd = cfg.cmd,
        root_dir = root_dir,
        cmd_env = cfg.cmd_env,
        capabilities = capabilities,
        on_attach = on_attach,
        settings = cfg.settings,
        single_file_support = cfg.single_file_support,
      })
    end,
    desc = string.format("Start LSP: %s", name),
  })
end
```

## lua/lsp-noise.lua

Role: Project file included for full context.

```
-- Suppress noisy LSP window/showMessage popups from gopls, especially
-- those triggered by inlay hints for files without package metadata.

local lsp = vim.lsp

local function map_level(typ)
  -- LSP: 1=Error, 2=Warning, 3=Info, 4=Log
  if typ == 1 then return vim.log.levels.ERROR end
  if typ == 2 then return vim.log.levels.WARN end
  return vim.log.levels.INFO
end

lsp.handlers["window/showMessage"] = function(_, result, ctx)
  local client = lsp.get_client_by_id(ctx.client_id)
  local name = client and client.name or "lsp"
  local msg = (result and result.message) or ""
  local typ = (result and result.type) or 3

  if name == "gopls" then
    -- Drop low-severity chatter and known noisy messages.
    if typ >= 3 then return end
    if msg:find("InlayHint") or msg:find("no package metadata for file") then return end
  end

  vim.notify(name .. ": " .. msg, map_level(typ))
end
```

## lua/plugins/.luarc.json

Role: Project file included for full context.

```json
{
    "diagnostics.globals": [
        "vim"
    ]
}
```

## lua/plugins/autopairs.lua

Role: Project file included for full context.

```
return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup{}
        end
    }
}
```

## lua/plugins/black.lua

Role: Project file included for full context.

```
return {
  "alexanderbluhm/black.nvim",
  name = "black",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "black" then
      vim.cmd.colorscheme "black"
    end
  end,
}
```

## lua/plugins/bufdelete.lua

Role: Project file included for full context.

```
return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete", "Bwipeout" },
}
```

## lua/plugins/bufferline.lua

Role: Project file included for full context.

```
return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local ok, bufferline = pcall(require, "bufferline")
            if not ok then return end

            bufferline.setup({
                options = {
                    mode = "tabs",                    -- show Vim tabs (not buffers)
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    always_show_bufferline = true,
                    separator_style = "thin",         -- keep rectangle blocks
                    diagnostics = false,
                    themable = true,
                    tab_size = 18,
                    max_name_length = 22,
                },
            })
        end,
    },
}
```

## lua/plugins/catppuccin.lua

Role: Project file included for full context.

```
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "catppuccin" then
      vim.cmd.colorscheme "catppuccin"
    end
  end,
}
```

## lua/plugins/cmp.lua

Role: Project file included for full context.

```
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = (function()
                if vim.fn.executable("make") == 1 then
                    return "make install_jsregexp"
                end
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true 
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}
```

## lua/plugins/conform.lua

Role: Project file included for full context.

```
-- Plugin to provide formatting using external tools (including sql-formatter)
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        sql = { "sql_formatter" },
        kotlin = { "ktlint" },
      },
    })

    -- Optional: format Kotlin on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.kt", "*.kts" },
      callback = function(args)
        conform.format({ bufnr = args.buf, lsp_fallback = true, quiet = true })
      end,
      group = vim.api.nvim_create_augroup("ConformKotlinFormatOnSave", { clear = true }),
    })
  end,
}
```

## lua/plugins/coverage.lua

Role: Project file included for full context.

```
return {
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageSummary",
      "CoverageClear",
    },
    keys = {
      { "<leader>cl", "<cmd>CoverageLoad<CR>",   desc = "Coverage: Load profile" },
      { "<leader>cs", "<cmd>CoverageShow<CR>",   desc = "Coverage: Show highlights" },
      { "<leader>ch", "<cmd>CoverageHide<CR>",   desc = "Coverage: Hide highlights" },
      { "<leader>cc", "<cmd>CoverageClear<CR>",  desc = "Coverage: Clear coverage" },
    },
    config = function()
      local ok, coverage = pcall(require, "coverage")
      if not ok then return end
      coverage.setup({
        auto_reload = true,
      })

      local function apply_coverage_highlights()
        -- Green for covered, red for uncovered (subtle backgrounds)
        vim.api.nvim_set_hl(0, "CoverageCovered",   { bg = "#16381d" })
        vim.api.nvim_set_hl(0, "CoverageUncovered", { bg = "#3b0e0e" })
      end

      apply_coverage_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("CoverageHL", { clear = true }),
        callback = apply_coverage_highlights,
      })

      -- When a coverage profile is written, reload and show it
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("CoverageAutoReload", { clear = true }),
        pattern = "coverage.out",
        callback = function()
          vim.cmd("CoverageLoad | CoverageShow")
        end,
      })
    end,
  },
}
```

## lua/plugins/cursorline.lua

Role: Project file included for full context.

```
return {
  "ya2s/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = false,  -- Use native cursorline to avoid blink
        timeout = 0,
        number = false,
      },
      cursorword = {
        enable = false,   -- Disable word underlining; only current line highlight remains
        min_length = 3,
        hl = { underline = true },
      }
    }
  end
}
```

## lua/plugins/diffview.lua

Role: Project file included for full context.

```
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
                win_config = { position = "left", width = 35 },
            },
            view = {
                default = {
                    layout = "diff2_horizontal",
                },
            },
            keymaps = {
                view = {
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file_edit,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
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
                },
            },
        })
    end,
}
```

## lua/plugins/gitsigns.lua

Role: Project file included for full context.

```
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
        })
        vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "git blame line" })
        vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "git reset hunk" })
    end,
}
```

## lua/plugins/gruvbox.lua

Role: Project file included for full context.

```
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Ensure our Normal highlight override is applied whenever Gruvbox is set
    local augroup = vim.api.nvim_create_augroup("gruvbox-normal-bg", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      pattern = "gruvbox",
      callback = function()
        local color = vim.g.gruvbox_bg_color or "#101010" -- slightly grey instead of pure black
        vim.cmd(("hi Normal guibg=%s ctermbg=NONE"):format(color))
      end,
    })

    if vim.g.colorscheme == "gruvbox" then
      vim.cmd.colorscheme "gruvbox"
    end
  end,
}
```

## lua/plugins/lsp-config.lua

Role: Project file included for full context.

```
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "sqlls",
                    "buf_ls",
                    "pyright",
                    "clangd",
                    "html",
                    "cssls",
                    "yamlls",
                    "bashls",
                    "jdtls",
                    "vimls",
                    "jsonls",
                    "kotlin_language_server",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()

            -- UI: signature help floating window style
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }
            )

            -- Root detection using core vim.fs (avoid lspconfig framework)
            local function compute_root(patterns, buf)
                local path = vim.api.nvim_buf_get_name(buf or 0)
                local start_dir = (path ~= '' and vim.fs.dirname(path)) or (vim.uv and vim.uv.cwd()) or vim.loop.cwd()
                local found = vim.fs.find(patterns, { upward = true, path = start_dir })[1]
                return found and vim.fs.dirname(found) or start_dir
            end

            -- Deduplicate LSP locations by uri + start position
            local function dedupe_locations(locations)
                if not locations or vim.tbl_isempty(locations) then return {} end
                local seen = {}
                local unique = {}
                for _, loc in ipairs(locations) do
                    local uri = loc.uri or loc.targetUri or ""
                    local range = loc.range or loc.targetSelectionRange or loc.targetRange or { start = { line = -1, character = -1 } }
                    local s = range.start or { line = -1, character = -1 }
                    local key = string.format("%s:%d:%d", uri, s.line or -1, s.character or -1)
                    if not seen[key] then
                        seen[key] = true
                        table.insert(unique, loc)
                    end
                end
                return unique
            end

            -- Present a list of locations in Telescope without re-requesting the LSP
            local function present_locations_with_telescope(locations, title)
                local ok, pickers = pcall(require, 'telescope.pickers')
                if not ok then
                    vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(locations, 'utf-8'))
                    vim.cmd('copen')
                    return
                end
                local finders = require('telescope.finders')
                local conf = require('telescope.config').values
                local make_entry = require('telescope.make_entry')
                local items = vim.lsp.util.locations_to_items(locations, 'utf-8')
                pickers.new({}, {
                    prompt_title = title or 'LSP Results',
                    finder = finders.new_table({
                        results = items,
                        entry_maker = make_entry.gen_from_quickfix(),
                    }),
                    sorter = conf.generic_sorter({}),
                    previewer = conf.qflist_previewer({}),
                }):find()
            end

            -- Compatibility helper for opening LSP locations without using deprecated APIs
            local function open_lsp_location(location)
                local util = vim.lsp.util
                if util and util.show_document then
                    if location.targetUri then
                        util.show_document({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
                    else
                        util.show_document(location, "utf-8")
                    end
                else
                    -- Fallback for older Neovim versions
                    if location.targetUri then
                        util.jump_to_location({ uri = location.targetUri, range = location.targetSelectionRange or location.targetRange }, "utf-8")
                    else
                        util.jump_to_location(location, "utf-8")
                    end
                end
            end

            local function jump_to_first_location_or_picker(result, picker_name)
                if not result or vim.tbl_isempty(result) then return false end
                local locations = result
                -- Some servers return a table with a single element being the result
                if result.result then locations = result.result end
                if not locations or vim.tbl_isempty(locations) then return false end
                locations = dedupe_locations(locations)
                if #locations == 1 then
                    local loc = locations[1]
                    open_lsp_location(loc)
                else
                    -- Multiple results: show Telescope picker using these exact (deduped) locations
                    present_locations_with_telescope(locations, 'LSP ' .. (picker_name or 'Results'))
                end
                return true
            end

            local function goto_definition_smart()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, def)
                    if jump_to_first_location_or_picker(def, 'lsp_definitions') then return end
                    -- Fallback to type definition (common for Go struct/iface types)
                    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(_, tdef)
                        if jump_to_first_location_or_picker(tdef, 'lsp_type_definitions') then return end
                        -- Last resort: declaration
                        vim.lsp.buf.declaration()
                    end)
                end)
            end

            -- Note: use buffer-local mappings in on_attach; avoid global expr mappings to prevent timeouts

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                local buf_set_keymap = function(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end
                if client:supports_method("textDocument/inlayHint") then
                    local name = vim.api.nvim_buf_get_name(bufnr)
                    if name:sub(-3) == ".go" then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end

                if client:supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                end

                local builtin = require('telescope.builtin')
                buf_set_keymap('n', 'gd', goto_definition_smart, { desc = 'LSP Definition (smart)' })
                buf_set_keymap('n', 'gT', function()
                    local params = vim.lsp.util.make_position_params()
                    vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, function(_, tdef)
                        local ok = jump_to_first_location_or_picker(tdef, 'Type Definitions')
                        if not ok then return end
                    end)
                end, { desc = 'LSP Type Definition (deduped)' })
                buf_set_keymap('n', 'gi', builtin.lsp_implementations, { desc = 'LSP Implementation (Telescope)' })
                buf_set_keymap('n', 'gr', builtin.lsp_references, { desc = 'LSP References (Telescope)' })
                buf_set_keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
                buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
                buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
                buf_set_keymap('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
                buf_set_keymap('n', 'K', vim.lsp.buf.hover, { desc = "Hover" })
                buf_set_keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                buf_set_keymap('n', '<leader>e', function()
                    local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
                    if diags and #diags > 0 then
                        vim.diagnostic.open_float(nil, { scope = 'line', focus = false })
                        return
                    end
                    local ok, builtin = pcall(require, 'telescope.builtin')
                    if ok then
                        builtin.diagnostics({ bufnr = 0, prompt_title = 'Current File Diagnostics' })
                    else
                        vim.diagnostic.setloclist({ open = true })
                    end
                end, { desc = "Diagnostics: float/peek", nowait = true })
            end

            -- Define servers using core vim.lsp.start (no lspconfig framework)
            local servers = {
                kotlin_language_server = {
                    cmd = { "kotlin-language-server" },
                    filetypes = { "kotlin" },
                    root_patterns = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", ".git" },
                    settings = {
                        kotlin = {
                            compiler = { jvm = { target = "17" } },
                        },
                    },
                },
                jdtls = {
                    cmd = { "jdtls" },
                    filetypes = { "java" },
                    root_patterns = { "gradlew", "mvnw", ".git" },
                    single_file_support = true,
                },
                gopls = {
                    cmd = { "gopls" },
                    cmd_env = { GOMEMLIMIT = "2GiB" },
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    -- Avoid .git as root; scope to module/workspace files
                    root_patterns = { "go.work", "go.mod" },
                    settings = {
                        gopls = {
                            usePlaceholders = true,
                            staticcheck = false,
                            completeUnimported = false,
                            completionBudget = "100ms",
                            matcher = "CaseSensitive",
                            expandWorkspaceToModule = true,
                            directoryFilters = {
                                "-.git",
                                "-node_modules",
                                "-vendor",
                                "-bazel-bin",
                                "-bazel-out",
                                "-bazel-testlogs",
                                "-build",
                                "-bin",
                                "-out",
                                "-target",
                                "-.cache",
                            },
                            analyses = { unusedparams = true, shadow = true },
                            codelenses = { test = true, tidy = true, upgrade_dependency = true },
                            memoryMode = "DegradeClosed",
                            diagnosticsDelay = "300ms",
                            hints = {
                                assignVariableTypes = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    cmd = { "lua-language-server" },
                    filetypes = { "lua" },
                    root_patterns = { ".luarc.json", ".luacheckrc", ".git" },
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                },
                pyright = {
                    cmd = { "pyright-langserver", "--stdio" },
                    filetypes = { "python" },
                    root_patterns = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
                },
                clangd = {
                    cmd = { "clangd" },
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                    root_patterns = { "compile_commands.json", "CMakeLists.txt", ".git" },
                },
                bashls = {
                    cmd = { "bash-language-server", "start" },
                    filetypes = { "sh", "bash" },
                    root_patterns = { ".git" },
                },
                jsonls = {
                    cmd = { "vscode-json-language-server", "--stdio" },
                    filetypes = { "json", "jsonc" },
                    root_patterns = { ".git" },
                },
                yamlls = {
                    cmd = { "yaml-language-server", "--stdio" },
                    filetypes = { "yaml", "yml" },
                    root_patterns = { ".git" },
                },
                cssls = {
                    cmd = { "vscode-css-language-server", "--stdio" },
                    filetypes = { "css", "scss", "less" },
                    root_patterns = { ".git" },
                },
                html = {
                    cmd = { "vscode-html-language-server", "--stdio" },
                    filetypes = { "html" },
                    root_patterns = { ".git" },
                },
                vimls = {
                    cmd = { "vim-language-server", "--stdio" },
                    filetypes = { "vim" },
                    root_patterns = { ".git" },
                },
            }

            local group = vim.api.nvim_create_augroup("UserLspAutoStart", { clear = true })
            for name, cfg in pairs(servers) do
                vim.api.nvim_create_autocmd("FileType", {
                    group = group,
                    pattern = cfg.filetypes or {},
                    callback = function(args)
                        local root_dir = compute_root(cfg.root_patterns or { ".git" }, args.buf)
                        if name == 'gopls' then
                            local has_go_mod = (vim.uv or vim.loop).fs_stat(root_dir .. "/go.mod") ~= nil
                            local has_go_work = (vim.uv or vim.loop).fs_stat(root_dir .. "/go.work") ~= nil
                            if not (has_go_mod or has_go_work) then
                                return
                            end
                        end
                        -- Avoid starting if a matching client is already attached
                        local existing = vim.lsp.get_clients({ bufnr = args.buf, name = name })
                        if existing and #existing > 0 then return end
                        vim.lsp.start({
                            name = name,
                            cmd = cfg.cmd,
                            root_dir = root_dir,
                            cmd_env = cfg.cmd_env,
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = cfg.settings,
                            single_file_support = cfg.single_file_support,
                        })
                    end,
                    desc = string.format("Start LSP: %s", name),
                })
            end

        end,
    }
}
```

## lua/plugins/lualine.lua

Role: Project file included for full context.

```
return {
    "nvim-lualine/lualine.nvim",
    config = function()
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
                }
            }
        })
    end
}
```

## lua/plugins/mdpreview.lua

Role: Project file included for full context.

```
return {
  "mrjones2014/mdpreview.nvim",
  ft = { "markdown" },
  dependencies = {
  },
  config = function()
    vim.g.mdpreview_auto_start = 1
    vim.g.mdpreview_position = "left"
  end,
}
```

## lua/plugins/monochrome.lua

Role: Project file included for full context.

```
return {
  "fxn/vim-monochrome",
  name = "monochrome",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "monochrome" then
      vim.cmd.colorscheme "monochrome"
    end
  end,
}
```

## lua/plugins/neoscroll.lua

Role: Project file included for full context.

```
return {
  "karb94/neoscroll.nvim",
  opts = {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
    hide_cursor = false, -- Keep cursor visible for smooth trail plugins
    stop_eof = true, -- Stop at end of file
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = "cubic", -- Smoother easing
    pre_hook = nil, -- Function to run before the scrolling animation starts
    post_hook = nil, -- Function to run after the scrolling animation ends
    performance_mode = false, -- Disable "Performance Mode" on all buffers.
  },
}
```

## lua/plugins/pounce.lua

Role: Project file included for full context.

```
return {
    {
        'rlane/pounce.nvim',
        config = function()
            require('pounce').setup({
                accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
                accept_best_key = "<enter>",
                multi_window = true,
                debug = false,
            })

            -- Key mappings
            vim.keymap.set("n", "s", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("n", "S", "<cmd>Pounce<CR>", { desc = "Pounce (visual)" })
            vim.keymap.set("o", "s", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("o", "S", "<cmd>Pounce<CR>", { desc = "Pounce" })
            vim.keymap.set("i", "<c-s>", "<cmd>Pounce<CR>", { desc = "Pounce" })
        end
    }
}
```

## lua/plugins/ray-x.lua

Role: Project file included for full context.

```
return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    config = function()
      require("go").setup({
        lsp_cfg = true,
        dap_debug = false,
        trouble = true,
      })

      -- Optional: quick coverage keymaps
      vim.keymap.set("n", "<leader>gs", ":GoCoverage<CR>", { desc = "Go: Show coverage" })
      vim.keymap.set("n", "<leader>gS", ":GoCoverageClear<CR>", { desc = "Go: Clear coverage" })
    end,
    event = {"CmdlineEnter"},
    ft = { "go", "gomod", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()'
  }
}
```

## lua/plugins/retro-terminal.lua

Role: Project file included for full context.

```
-- Retro Terminal colorscheme loader
-- Uses a dummy github repo pattern to satisfy lazy.nvim
return {
  dir = vim.fn.stdpath("config") .. "/colors",  -- Local directory
  name = "retro-terminal",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.colorscheme == "retro-terminal" then
      vim.cmd.colorscheme "retro-terminal"
    end
  end,
}
```

## lua/plugins/spectre.lua

Role: Project file included for full context.

```
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
```

## lua/plugins/telescope.lua

Role: Project file included for full context.

```
return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', "folke/todo-comments.nvim", "nvim-telescope/telescope-file-browser.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            local diag_prefix = require("util.diag_prefix")

            -- Helper: normalize various entry types from pickers/extensions to a string path
            local function norm_path(arg)
                if type(arg) == 'string' then return arg end
                if type(arg) == 'table' then
                    return arg.path or arg.filename or arg.value or arg[1] or ''
                end
                return ''
            end

            -- Render file paths as absolute (home as ~) in pickers
            local function abs_path_display(_, path)
                path = norm_path(path)
                -- :p = absolute; :~ = home as ~
                local p = vim.fn.fnamemodify(path, ":p")
                p = vim.fn.fnamemodify(p, ":~")
                return p
            end

            telescope.setup({
                defaults = {
                    previewer = true,
                    previewer = true,
                    sorting_strategy = 'ascending',
                    -- Show full absolute paths (with ~ for home)
                    path_display = abs_path_display,
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob", "!**/.git/**",
                    },
                    -- This is the key to jumping to the right line
                    jump_type = "exact",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,   -- always show preview, even on short windows
                        preview_height = 0.5, -- 50% of Telescope height for preview pane
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--no-ignore" },
                    },
                    live_grep = {
                        additional_args = function(opts)
                            return {
                                "--glob", "!**/.git/**",
                                -- General Exclusions
                                "--glob", "!*.log",
                                "--glob", "!*.tmp",
                                "--glob", "!*.bak",
                                "--glob", "!*.swp",
                                "--glob", "!*.swo",
                                "--glob", "!*.zip",
                                "--glob", "!*.tar.gz",
                                "--glob", "!*.rar",
                                "--glob", "!*.7z",
                                -- Binary / Build Artifacts
                                "--glob", "!*.pdf",
                                "--glob", "!*.png",
                                "--glob", "!*.jpg",
                                "--glob", "!*.jpeg",
                                "--glob", "!*.gif",
                                "--glob", "!*.svg",
                                "--glob", "!*.ico",
                                "--glob", "!*.pyc",
                                "--glob", "!*.o",
                                "--glob", "!*.so",
                                "--glob", "!*.dll",
                                "--glob", "!*.exe",
                                "--glob", "!*.class",
                                "--glob", "!*.jar",
                                -- Minified files
                                "--glob", "!*.min.js",
                                "--glob", "!*.min.css",
                                -- Go specific
                                "--glob", "!go.mod",
                                "--glob", "!go.sum",
                                "--glob", "!vendor/**",
                                "--glob", "!*.pb.go",
                                "--glob", "!*.pb.gw.go",
                                "--glob", "!*.pb.scratch.go",
                                "--glob", "!*.pb.sensitivity.go",
                                -- Node specific
                                "--glob", "!node_modules/**",
                                "--glob", "!package-lock.json",
                                "--glob", "!yarn.lock",
                                -- Other common build directories
                                "--glob", "!dist/**",
                                "--glob", "!build/**",
                                "--glob", "!target/**",
                                -- Lock files
                                "--glob", "!Pipfile.lock",
                                "--glob", "!composer.lock",
                                "--glob", "!cover.out",
                                "--glob", "!coverage.out",
                            }
                        end,
                    },
                    -- Ensure LSP pickers (gd, gi, gr) show the whole file path
                    lsp_references = {
                        previewer = true,
                        fname_width = 200,
                        path_display = abs_path_display,
                        show_line = true,
                    },
                    lsp_definitions = {
                        fname_width = 200,
                        path_display = abs_path_display,
                        show_line = true,
                    },
                    lsp_implementations = {
                        fname_width = 200,
                        path_display = abs_path_display,
                        show_line = true,
                    },
                },
                extensions = {
                    -- ["ui-select"] = {
                    --     require("telescope.themes").get_dropdown {}
                    -- }
                    file_browser = {
                        hijack_netrw = false,
                        grouped = true,
                        hidden = true,
                        mappings = {
                            ["i"] = {
                                ["<C-t>"] = actions.select_tab,
                            },
                            ["n"] = {
                                ["t"] = actions.select_tab,
                                ["<C-t>"] = actions.select_tab,
                            },
                        }
                    }
                }
            })

            -- telescope.load_extension("ui-select")
            telescope.load_extension("todo-comments")
            telescope.load_extension("file_browser")

            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
            -- Enhanced diagnostics viewing
            vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = "View all diagnostics" })
            vim.keymap.set('n', '<leader>de', function()
                builtin.diagnostics({
                    severity_limit = "Error",
                    prompt_title = "Errors Only"
                })
            end, { desc = "View errors only" })
            vim.keymap.set('n', '<leader>dw', function()
                builtin.diagnostics({
                    severity_limit = "Warning",
                    prompt_title = "Warnings and Errors"
                })
            end, { desc = "View warnings and errors" })
            vim.keymap.set('n', '<leader>df', function()
                builtin.diagnostics({
                    bufnr = 0,
                    prompt_title = "Current File Diagnostics"
                })
            end, { desc = "View current file diagnostics" })
            
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
            vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = "Git buffer commits" })
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
            vim.keymap.set('n', '<leader>ft', "<cmd>Telescope todo-comments<cr>", { desc = "Find todos" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })

            -- Live grep with literal search (no regex needed)
            vim.keymap.set('n', '<leader>fF', function()
                builtin.live_grep({
                    additional_args = function()
                        return { '-F' }
                    end,
                })
            end, { desc = "Live Grep (literal)" })

            -- Helper to render with diagnostics prefix (only for already-listed buffers)
            local function with_diag_prefix(path)
                local p = norm_path(path)
                return (diag_prefix.prefix_for_path(p) or "") .. abs_path_display(nil, p)
            end

            -- Floating file browser with preview at project root
            vim.keymap.set('n', '<leader>fe', function()
                require('telescope').extensions.file_browser.file_browser({
                    cwd = vim.loop.cwd(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = true,
                    path_display = function(_, path)
                        -- diagnostics prefix + absolute path
                        local p = norm_path(path)
                        return (diag_prefix.prefix_for_path(p) or "") .. abs_path_display(nil, p)
                    end,
                    initial_mode = "normal",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,
                        preview_height = 0.5,
                    },
                })
            end, { desc = "File browser (project root)" })

            -- Quickly open file browser at current buffer's directory
            vim.keymap.set('n', '-', function()
                local fb = require('telescope').extensions.file_browser
                local here = vim.fn.expand("%:p:h")
                fb.file_browser({
                    cwd = here,
                    select_buffer = true,
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = true,
                    path_display = function(_, path)
                        -- diagnostics prefix + absolute path
                        local p = norm_path(path)
                        return (diag_prefix.prefix_for_path(p) or "") .. abs_path_display(nil, p)
                    end,
                    initial_mode = "normal",
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 0,
                        preview_height = 0.5,
                    },
                })
            end, { desc = "File browser (current file dir)" })

            vim.keymap.set('n', '<leader>ff', function()
                builtin.live_grep({
                    additional_args = {
                        -- regex (default) search with filters
                        "--glob", "!**/.git/**",
                        "--glob", "!**/*_mock*",
                        "--glob", "!*.pb",
                        "--glob", "!*.pb.go",
                        "--glob", "!*.pb.scratch.go",
                        "--glob", "!*.pb.gw.go",
                        "--glob", "!*.pb.sensitivity.go",
                        "--glob", "!*.log",
                        "--glob", "!*.tmp",
                        "--glob", "!*.bak",
                        "--glob", "!*.swp",
                        "--glob", "!*.swo",
                        "--glob", "!*.min.js",
                        "--glob", "!*.min.css",
                        "--glob", "!*.lock",
                        "--glob", "!*.zip",
                        "--glob", "!*.tar.gz",
                        "--glob", "!*.rar",
                        "--glob", "!*.7z",
                        "--glob", "!*.pdf",
                        "--glob", "!*.png",
                        "--glob", "!*.jpg",
                        "--glob", "!*.jpeg",
                        "--glob", "!*.gif",
                        "--glob", "!*.svg",
                        "--glob", "!*.ico",
                        "--glob", "!*.pyc",
                        "--glob", "!*.o",
                        "--glob", "!*.so",
                        "--glob", "!*.dll",
                        "--glob", "!*.exe",
                        "--glob", "!*.class",
                        "--glob", "!*.jar"
                    }
                })
            end, { desc = "Live Grep (filtered)" })

            -- Literal (fixed-string) grep: special characters don't need escaping
            vim.keymap.set('n', '<leader>fF', function()
                builtin.live_grep({
                    prompt_title = "Literal Grep (-F)",
                    additional_args = {
                        "-F", -- treat the pattern as a literal string
                        "--glob", "!**/.git/**",
                        "--glob", "!**/*_mock*",
                        "--glob", "!*.pb",
                        "--glob", "!*.pb.go",
                        "--glob", "!*.pb.scratch.go",
                        "--glob", "!*.pb.gw.go",
                        "--glob", "!*.pb.sensitivity.go",
                        "--glob", "!*.log",
                        "--glob", "!*.tmp",
                        "--glob", "!*.bak",
                        "--glob", "!*.swp",
                        "--glob", "!*.swo",
                        "--glob", "!*.min.js",
                        "--glob", "!*.min.css",
                        "--glob", "!*.lock",
                        "--glob", "!*.zip",
                        "--glob", "!*.tar.gz",
                        "--glob", "!*.rar",
                        "--glob", "!*.7z",
                        "--glob", "!*.pdf",
                        "--glob", "!*.png",
                        "--glob", "!*.jpg",
                        "--glob", "!*.jpeg",
                        "--glob", "!*.gif",
                        "--glob", "!*.svg",
                        "--glob", "!*.ico",
                        "--glob", "!*.pyc",
                        "--glob", "!*.o",
                        "--glob", "!*.so",
                        "--glob", "!*.dll",
                        "--glob", "!*.exe",
                        "--glob", "!*.class",
                        "--glob", "!*.jar"
                    }
                })
            end, { desc = "Live Grep (literal, no regex)" })
        end
    }
}
```

## lua/plugins/todo-comments.lua

Role: Project file included for full context.

```
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}
```

## lua/plugins/treesitter.lua

Role: Project file included for full context.

```
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
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
                  "kotlin",  -- for Kotlin
                  "java",    -- for Java
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
                  ["]a"] = "@parameter.inner",
                },
                goto_previous_start = {
                  ["[f"] = "@function.outer",
                  ["[c"] = "@class.outer",
                  ["[a"] = "@parameter.inner",
                },
                goto_next_end = {
                  ["]A"] = "@parameter.inner",
                },
                goto_previous_end = {
                  ["[A"] = "@parameter.inner",
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
```

## lua/util/diag_prefix.lua

Role: Project file included for full context.

```
local M = {}

-- Return a short diagnostics prefix (e.g. "2 1 ") for a given filepath.
-- Only counts diagnostics for already-listed buffers to avoid loading files.
function M.prefix_for_path(path)
  if type(path) ~= 'string' or path == '' then
    return ''
  end

  -- Normalize path to absolute for comparison
  local abs
  if vim.loop and vim.loop.fs_realpath then
    abs = vim.loop.fs_realpath(path)
  end
  abs = abs or vim.fn.fnamemodify(path, ":p")

  local bufnr_for_path
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(b)
    if name ~= '' then
      local n = name
      if vim.loop and vim.loop.fs_realpath then
        n = vim.loop.fs_realpath(name) or name
      end
      if n == abs then
        bufnr_for_path = b
        break
      end
    end
  end

  if not bufnr_for_path then
    return ''
  end

  local severities = vim.diagnostic.severity
  local diags = vim.diagnostic.get(bufnr_for_path)
  if not diags or #diags == 0 then
    return ''
  end

  local counts = { [severities.ERROR] = 0, [severities.WARN] = 0, [severities.HINT] = 0, [severities.INFO] = 0 }
  for _, d in ipairs(diags) do
    counts[d.severity] = (counts[d.severity] or 0) + 1
  end

  local parts = {}
  -- Icons follow common Nerd Font set; adjust to your glyphs if needed
  if counts[severities.ERROR] > 0 then table.insert(parts, "" .. counts[severities.ERROR]) end
  if counts[severities.WARN]  > 0 then table.insert(parts, "" .. counts[severities.WARN])  end
  if counts[severities.INFO]  > 0 then table.insert(parts, "" .. counts[severities.INFO])  end
  if counts[severities.HINT]  > 0 then table.insert(parts, "" .. counts[severities.HINT])  end

  if #parts == 0 then
    return ''
  end
  return table.concat(parts, ' ') .. ' '
end

return M
```

## lua/vim-options.lua

Role: Project file included for full context.

```
vim.g.colorscheme = "gruvbox" -- default theme
vim.g.gruvbox_bg_color = "#101010" -- default: slightly grey background for gruvbox

vim.cmd("set ignorecase")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 300 -- make key-seq timeout snappy (default ~1000ms)
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.hidden = true
vim.g.mapleader = " "
vim.cmd("set wrap")
vim.cmd("set linespace=2")

-- Netrw sane defaults
vim.g.netrw_banner = 0            -- hide banner
vim.g.netrw_liststyle = 3         -- tree view
vim.g.netrw_keepdir = 1           -- keep :pwd stable when browsing

-- Helper: open netrw at a directory and place cursor on the current file (no extra highlighting)
local function open_netrw_dir(dir_path, opts)
  opts = opts or {}
  local previous_file = vim.fn.expand('%:p')
  -- Remember the previous buffer in this tab to return to it on cancel
  vim.t.netrw_prev_buf = vim.api.nvim_get_current_buf()
  if opts.sidebar then
    vim.cmd('topleft vsplit')
    vim.cmd('vertical resize 30')
    vim.cmd('keepalt keepjumps edit ' .. vim.fn.fnameescape(dir_path))
  else
    vim.cmd('keepalt keepjumps edit ' .. vim.fn.fnameescape(dir_path))
  end
  local focus_name = opts.focus_name
  if not focus_name or focus_name == '' then
    focus_name = vim.fn.fnamemodify(previous_file, ':t')
  end
  if focus_name == '' then return end
  pcall(vim.cmd, 'normal! gg')
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local target_line = nil
  for i, line in ipairs(lines) do
    if (#line >= #focus_name and line:sub(-#focus_name) == focus_name)
      or (#line >= #focus_name + 1 and line:sub(-(#focus_name + 1)) == focus_name .. '/') then
      target_line = i
      break
    end
  end
  if target_line then
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
  end
end

-- Find a reasonable project root by walking up from a start directory
local function find_project_root(start_dir)
  local dir = start_dir or vim.fn.expand('%:p:h')
  if dir == "" or vim.fn.isdirectory(dir) == 0 then
    dir = vim.fn.getcwd()
  end
  local markers = { '.git', '.hg', '.svn', 'package.json', 'go.mod', 'pyproject.toml', 'Cargo.toml', 'Makefile' }
  local previous = nil
  while dir ~= previous do
    for _, marker in ipairs(markers) do
      if vim.fn.isdirectory(dir .. '/' .. marker) == 1 or vim.fn.filereadable(dir .. '/' .. marker) == 1 then
        return dir
      end
    end
    previous = dir
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then break end
    dir = parent
  end
  return vim.fn.getcwd()
end

-- In netrw, allow canceling (keep tab open): 'q' or <Esc>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom-netrw-mappings", { clear = true }),
  pattern = "netrw",
  callback = function(args)
    local netrw_buf = args.buf
    -- Capture previous buffer for this netrw instance
    if vim.t.netrw_prev_buf and vim.api.nvim_buf_is_valid(vim.t.netrw_prev_buf) then
      vim.b.netrw_prev_buf = vim.t.netrw_prev_buf
    elseif vim.fn.bufnr('#') > 0 and vim.api.nvim_buf_is_valid(vim.fn.bufnr('#')) then
      vim.b.netrw_prev_buf = vim.fn.bufnr('#')
    end
    local function close_netrw()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1 then
        -- Multiple windows: only close the netrw window
        pcall(vim.api.nvim_win_close, 0, true)
        return
      end
      -- Single window: switch back to previous buffer if possible
      local prev = vim.b.netrw_prev_buf
      if prev and vim.api.nvim_buf_is_valid(prev) and prev ~= netrw_buf then
        pcall(vim.api.nvim_set_current_buf, prev)
      else
        local alt = vim.fn.bufnr('#')
        if alt > 0 and vim.api.nvim_buf_is_valid(alt) and alt ~= netrw_buf then
          pcall(vim.cmd, 'buffer #')
        else
          -- Fallback to any listed normal buffer
          local fallback = nil
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(b)
              and vim.bo[b].buflisted
              and vim.bo[b].buftype == ''
              and b ~= netrw_buf then
              fallback = b
              break
            end
          end
          if fallback then
            pcall(vim.api.nvim_set_current_buf, fallback)
          end
        end
      end
      if vim.api.nvim_buf_is_valid(netrw_buf) then
        pcall(vim.cmd, 'bdelete ' .. netrw_buf)
      end
    end
    vim.keymap.set("n", "q", close_netrw, { buffer = netrw_buf, nowait = true, silent = true, desc = "Quit netrw (cancel)" })
    vim.keymap.set("n", "<Esc>", close_netrw, { buffer = netrw_buf, nowait = true, silent = true, desc = "Quit netrw (cancel)" })
    
    -- File management shortcuts
    vim.keymap.set("n", "a", "%", { buffer = netrw_buf, nowait = true, silent = true, desc = "Create new file" })
    vim.keymap.set("n", "A", "d", { buffer = netrw_buf, nowait = true, silent = true, desc = "Create new directory" })
    vim.keymap.set("n", "r", "R", { buffer = netrw_buf, nowait = true, silent = true, desc = "Rename file/directory" })
    vim.keymap.set("n", "dd", "D", { buffer = netrw_buf, nowait = true, silent = true, desc = "Delete file/directory" })
    vim.keymap.set("n", "yy", function()
      -- Copy file - get filename under cursor and prompt for destination
      local filename = vim.fn.expand("<cfile>")
      if filename == "" then
        print("No file under cursor")
        return
      end
      local dest = vim.fn.input("Copy '" .. filename .. "' to: ", filename .. "_copy")
      if dest ~= "" then
        local cmd = "cp " .. vim.fn.shellescape(filename) .. " " .. vim.fn.shellescape(dest)
        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          print("Copied: " .. filename .. " -> " .. dest)
          vim.cmd("keepjumps edit .") -- Refresh netrw without adding a jump
        else
          print("Copy failed: " .. result)
        end
      end
    end, { buffer = netrw_buf, nowait = true, silent = true, desc = "Copy file" })
    
    -- Additional helpful shortcuts
    vim.keymap.set("n", ".", function()
      vim.cmd("keepjumps edit .") -- Refresh netrw view without adding a jump
    end, { buffer = netrw_buf, nowait = true, silent = true, desc = "Refresh view" })
    
    vim.keymap.set("n", "h", "-", { buffer = netrw_buf, nowait = true, silent = true, desc = "Go up directory" })
    vim.keymap.set("n", "l", "<CR>", { buffer = netrw_buf, nowait = true, silent = true, desc = "Enter directory/open file" })

    -- Reset to initial root and re-focus the original file
    vim.keymap.set("n", "gr", function()
      local root = vim.t.netrw_initial_root or vim.fn.getcwd()
      local initial_file = vim.t.netrw_initial_file
      local focus = initial_file and vim.fn.fnamemodify(initial_file, ':t') or nil
      open_netrw_dir(root, { sidebar = false, focus_name = focus })
    end, { buffer = netrw_buf, nowait = true, silent = true, desc = "Reset file picker to initial state" })
  end,
})

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true, desc = "Clear search highlight" })

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to first non-whitespace character" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })

-- Mouse: enabled by default with a quick toggle
-- This allows normal mouse usage in Neovim (resize/splits/cursor/visual select)
-- and provides convenient commands to temporarily turn it off when you want
-- to use the terminal's native selection behavior.
vim.o.mouse = "a"

local function set_mouse(enabled)
  if enabled then
    vim.o.mouse = "a"
    vim.g.mouse_enabled = true
    vim.notify("Mouse: enabled", vim.log.levels.INFO)
  else
    vim.o.mouse = ""
    vim.g.mouse_enabled = false
    vim.notify("Mouse: disabled (use terminal selection)", vim.log.levels.INFO)
  end
end

-- User commands to control mouse behavior
vim.api.nvim_create_user_command("MouseOn", function()
  set_mouse(true)
end, {})

vim.api.nvim_create_user_command("MouseOff", function()
  set_mouse(false)
end, {})

vim.api.nvim_create_user_command("MouseToggle", function()
  set_mouse(vim.o.mouse == "")
end, {})

-- Optional: temporary disable for quick terminal-style selection (5s)
vim.api.nvim_create_user_command("MouseOffTemp", function(opts)
  local ms = tonumber(opts.args) or 5000
  set_mouse(false)
  vim.defer_fn(function()
    -- Only re-enable if user hasn't manually re-enabled
    if vim.o.mouse == "" then set_mouse(true) end
  end, ms)
  vim.notify("Mouse: disabled for " .. ms .. "ms", vim.log.levels.INFO)
end, { nargs = "?" })

-- Keymap: <leader>m toggles mouse on/off
vim.keymap.set("n", "<leader>m", function()
  set_mouse(vim.o.mouse == "")
end, { desc = "Toggle mouse (on/off)" })


-- When mouse is enabled, make scroll wheel move the cursor instead of scrolling the window.
-- This mirrors cursor movement one would do with j/k (or gj/gk for wrapped lines).
local function set_scroll_moves_cursor(enable)
  local modes_nv = { "n", "v", "o" }
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true, desc = desc })
  end
  local function demap(mode, lhs)
    pcall(vim.keymap.del, mode, lhs)
  end
  if enable then
    -- Use visual-line motions for wrapped lines
    map(modes_nv, '<ScrollWheelUp>', 'gk', 'Cursor up (wheel)')
    map(modes_nv, '<ScrollWheelDown>', 'gj', 'Cursor down (wheel)')
    map('i', '<ScrollWheelUp>', '<C-o>gk', 'Cursor up (wheel)')
    map('i', '<ScrollWheelDown>', '<C-o>gj', 'Cursor down (wheel)')
    -- Faster with Shift: move 5 screen lines
    map(modes_nv, '<S-ScrollWheelUp>', '5gk', 'Cursor up x5 (wheel)')
    map(modes_nv, '<S-ScrollWheelDown>', '5gj', 'Cursor down x5 (wheel)')
    map('i', '<S-ScrollWheelUp>', '<C-o>5gk', 'Cursor up x5 (wheel)')
    map('i', '<S-ScrollWheelDown>', '<C-o>5gj', 'Cursor down x5 (wheel)')
    vim.g.scroll_moves_cursor = true
  else
    for _, m in ipairs({ modes_nv, 'i' }) do
      demap(m, '<ScrollWheelUp>')
      demap(m, '<ScrollWheelDown>')
      demap(m, '<S-ScrollWheelUp>')
      demap(m, '<S-ScrollWheelDown>')
    end
    vim.g.scroll_moves_cursor = false
  end
end

-- Enable this behavior by default
set_scroll_moves_cursor(true)

-- Commands to control the behavior at runtime
vim.api.nvim_create_user_command('ScrollCursorOn', function()
  set_scroll_moves_cursor(true)
  vim.notify('Scroll wheel moves cursor: enabled', vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('ScrollCursorOff', function()
  set_scroll_moves_cursor(false)
  vim.notify('Scroll wheel moves cursor: disabled', vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('ScrollCursorToggle', function()
  set_scroll_moves_cursor(not vim.g.scroll_moves_cursor)
  vim.notify('Scroll wheel moves cursor: ' .. ((vim.g.scroll_moves_cursor and 'enabled') or 'disabled'), vim.log.levels.INFO)
end, {})



-- Auto-reload files changed outside of Neovim
vim.opt.autoread = true
vim.opt.confirm = true -- prompt before losing changes when reloading

local auto_read_group = vim.api.nvim_create_augroup("auto-read", { clear = true })
-- Only trigger on focus/terminal events and avoid prompting when there are unsaved buffers
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = auto_read_group,
  callback = function()
    if #vim.fn.getbufinfo({ bufmodified = 1 }) == 0 then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = auto_read_group,
  callback = function(args)
    vim.notify("File changed on disk. Buffer reloaded: " .. (args.file or ""), vim.log.levels.INFO)
  end,
})

-- Manual reload shortcut
vim.keymap.set("n", "<leader>R", "<cmd>checktime<CR>", { desc = "Reload files changed on disk" })

-- Keymap to switch themes
vim.keymap.set("n", "<leader>th", function()
  local themes = { "gruvbox", "black", "catppuccin", "oxocarbon", "everforest", "monochrome" }
  vim.ui.select(themes, { prompt = "Select a theme" }, function(choice)
    if not choice then return end
    -- Set the global selector so theme plugin loaders can respect it
    vim.g.colorscheme = choice
    vim.cmd.colorscheme(choice)
  end)
end, { desc = "Switch theme" })

-- Quick Gruvbox background shade picker
vim.keymap.set("n", "<leader>gb", function()
  local shades = {
    "#000000", -- pure black
    "#0a0a0a",
    "#101010",
    "#121212",
    "#151515",
    "#1a1a1a",
    "#1e1e1e",
    "#222222",
  }
  vim.ui.select(shades, { prompt = "Gruvbox Normal bg" }, function(choice)
    if not choice then return end
    vim.g.gruvbox_bg_color = choice
    if vim.g.colorscheme == "gruvbox" then
      -- Re-apply to force highlight update
      vim.cmd("colorscheme gruvbox")
    end
  end)
end, { desc = "Gruvbox background shade" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s", "<cmd>split<CR>", { desc = "Split window horizontally" })

-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
-- Switch tabs without leader
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>ts", "<cmd>tab split<CR>", { desc = "Open current buffer in new tab" })
-- Duplicate current tab's active window in a new tab (alias)
vim.keymap.set("n", "<leader>tt", "<cmd>tab split<CR>", { desc = "Duplicate current tab" })

-- Open native netrw at project root and place cursor on current file
vim.keymap.set("n", "<leader>fe", function()
  local current_file_path = vim.fn.expand('%:p')
  local start_dir = vim.fn.expand('%:p:h')
  local root = find_project_root(start_dir)
  -- Record initial state for this tab so we can reset later from inside netrw
  vim.t.netrw_initial_root = root
  vim.t.netrw_initial_file = current_file_path
  open_netrw_dir(root, { sidebar = false, focus_name = vim.fn.fnamemodify(current_file_path, ':t') })
end, { desc = "Explore project root" })

-- Open netrw as a left sidebar from current file's directory (manual split + edit)
vim.keymap.set("n", "<leader>le", function()
  local file_dir = vim.fn.expand('%:p:h')
  if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
    file_dir = vim.fn.getcwd()
  end
  open_netrw_dir(file_dir, { sidebar = true })
end, { desc = "Left Explore (sidebar)" })

-- Quick open Explore with '-' like many terminals (edit directory in place)
vim.keymap.set("n", "-", function()
  local file_dir = vim.fn.expand('%:p:h')
  if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
    file_dir = vim.fn.getcwd()
  end
  open_netrw_dir(file_dir, { sidebar = false })
end, { desc = "Explore current directory" })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to clipboard" })

-- Copy full path of current file to clipboard
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  if path == "" then
    vim.notify("No file path to copy", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Yank file path to clipboard" })

-- Global file operations (work from anywhere)
vim.keymap.set("n", "<leader>nf", function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == "" or vim.fn.isdirectory(current_dir) == 0 then
    current_dir = vim.fn.getcwd()
  end
  local filename = vim.fn.input("New file name: ", current_dir .. "/")
  if filename ~= "" then
    vim.cmd("edit " .. vim.fn.fnameescape(filename))
  end
end, { desc = "Create new file" })

vim.keymap.set("n", "<leader>nd", function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == "" or vim.fn.isdirectory(current_dir) == 0 then
    current_dir = vim.fn.getcwd()
  end
  local dirname = vim.fn.input("New directory name: ", current_dir .. "/")
  if dirname ~= "" then
    vim.fn.mkdir(dirname, "p")
    print("Created directory: " .. dirname)
  end
end, { desc = "Create new directory" })

vim.keymap.set("n", "<leader>rf", function()
  local current_file = vim.fn.expand('%:p')
  if current_file == "" then
    print("No file to rename")
    return
  end
  local new_name = vim.fn.input("Rename file to: ", current_file)
  if new_name ~= "" and new_name ~= current_file then
    local success = vim.fn.rename(current_file, new_name)
    if success == 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(new_name))
      vim.cmd("bdelete #") -- Delete the old buffer
      print("Renamed: " .. vim.fn.fnamemodify(current_file, ':t') .. " -> " .. vim.fn.fnamemodify(new_name, ':t'))
    else
      print("Rename failed")
    end
  end
end, { desc = "Rename current file" })

vim.keymap.set("n", "<leader>df", function()
  local current_file = vim.fn.expand('%:p')
  if current_file == "" then
    print("No file to delete")
    return
  end
  local confirm = vim.fn.input("Delete '" .. vim.fn.fnamemodify(current_file, ':t') .. "'? (y/N): ")
  if confirm:lower() == "y" then
    local success = vim.fn.delete(current_file)
    if success == 0 then
      vim.cmd("bdelete!")
      print("Deleted: " .. vim.fn.fnamemodify(current_file, ':t'))
    else
      print("Delete failed")
    end
  end
end, { desc = "Delete current file" })

-- Buffer navigation and management
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Delete buffer (keep window)" })
vim.keymap.set("n", "<leader>ba", function()
  -- Delete all listed buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      pcall(vim.cmd, "Bdelete " .. buf)
    end
  end
end, { desc = "Delete all buffers" })
vim.keymap.set("n", "<leader>bo", function()
  -- Delete all other listed buffers
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      pcall(vim.cmd, "Bdelete " .. buf)
    end
  end
end, { desc = "Delete other buffers" })

-- Tab keymaps removed to keep workflow buffer-centric for now

-- Hide Neo-tree buffer from buffer list (so it won't show in tabline buffers)
-- Neo-tree was removed; cleanup of related autocmds is no longer necessary




-- Custom terminal setup
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
        -- Map Esc to exit terminal mode
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, buffer = true })
        -- Clear terminal screen + scrollback (similar to kitty Cmd+K)
        -- Note: Cmd+K is usually intercepted by the host terminal; use <C-k> inside Neovim terminal instead
        vim.keymap.set('t', '<C-k>', function()
            local job = vim.b.terminal_job_id
            if job then
                -- Clear screen then scrollback
                vim.fn.chansend(job, 'clear; printf "\\033[3J"\r')
            end
        end, { noremap = true, silent = true, buffer = true, desc = 'Clear terminal screen+scrollback' })
    end,
})

-- Auto-close terminal buffers when the job exits so :qa isn't blocked by dead terminals
vim.api.nvim_create_autocmd('TermClose', {
    group = vim.api.nvim_create_augroup('custom-term-close', { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype == 'terminal' then
            vim.schedule(function()
                pcall(vim.cmd, 'bdelete! ' .. args.buf)
            end)
        end
    end,
})

-- On quit, make sure all terminal buffers are wiped silently
vim.api.nvim_create_autocmd('QuitPre', {
    group = vim.api.nvim_create_augroup('custom-quit-cleanup', { clear = true }),
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'terminal' then
                pcall(vim.cmd, 'bdelete! ' .. buf)
            end
        end
    end,
})

-- Format SQL files on save using conform.nvim
-- Format-on-save for SQL with ability to temporarily disable
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.sql",
  callback = function()
    -- Respect buffer/global toggles
    if vim.b.sql_format_on_save == false or vim.g.sql_format_on_save == false then
      return
    end
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = false })
    end
  end,
})

-- User commands to toggle SQL format-on-save
vim.api.nvim_create_user_command("SqlFormatOnSaveDisable", function()
  vim.b.sql_format_on_save = false
  print("SQL format on save: disabled (buffer)")
end, {})

vim.api.nvim_create_user_command("SqlFormatOnSaveEnable", function()
  vim.b.sql_format_on_save = nil
  print("SQL format on save: enabled (buffer)")
end, {})

vim.api.nvim_create_user_command("SqlFormatOnSaveToggle", function()
  if vim.b.sql_format_on_save == false then
    vim.b.sql_format_on_save = nil
    print("SQL format on save: enabled (buffer)")
  else
    vim.b.sql_format_on_save = false
    print("SQL format on save: disabled (buffer)")
  end
end, {})

vim.api.nvim_create_user_command("SqlFormatOnSaveDisableGlobal", function()
  vim.g.sql_format_on_save = false
  print("SQL format on save: disabled (global)")
end, {})

vim.api.nvim_create_user_command("SqlFormatOnSaveEnableGlobal", function()
  vim.g.sql_format_on_save = nil
  print("SQL format on save: enabled (global)")
end, {})


vim.api.nvim_create_user_command("SqlFormatOnSaveToggleGlobal", function()
  if vim.g.sql_format_on_save == false then
    vim.g.sql_format_on_save = nil
    print("SQL format on save: enabled (global)")
  else
    vim.g.sql_format_on_save = false
    print("SQL format on save: disabled (global)")
  end
end, {})

-- Manual format when user types :w (Go only)
-- This does not use BufWritePre, so programmatic/auto writes are unaffected.
do
  local function format_then_write()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype
    if ft == 'go' then
      -- Prefer LSP formatting if available
      local has_fmt = false
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.supports_method and client:supports_method('textDocument/formatting') then
          has_fmt = true
          break
        end
      end
      if has_fmt then
        pcall(vim.lsp.buf.format, { bufnr = bufnr, async = false, timeout_ms = 2000 })
      else
        -- Fallback to conform (if installed) or go.nvim commands
        local ok_conform, conform = pcall(require, 'conform')
        if ok_conform then
          pcall(conform.format, { bufnr = bufnr, lsp_fallback = true, quiet = true })
        else
          -- Try go.nvim formatters if available
          pcall(vim.cmd, 'silent! GoImports')
          pcall(vim.cmd, 'silent! GoFmt')
        end
      end
    end
    vim.cmd('write')
  end

  -- Ex command used by the cnoreabbrev below
  vim.api.nvim_create_user_command('WFormatWrite', format_then_write, { nargs = 0 })

  -- Intercept exactly ":w" typed by the user (no args) and run formatter first
  vim.cmd([[cnoreabbrev <expr> w (getcmdtype() == ':' && getcmdline() =~# '^\s*w\s*$') ? 'WFormatWrite' : 'w']])
end

-- Fallback LSP keymaps
-- these will do nothing if the lsp is not attached
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float(nil, { scope = 'line' })
end, { desc = "Open diagnostics float" })
vim.keymap.set('n', 'gd', function()
  pcall(vim.lsp.buf.definition)
end, { silent = true, desc = "LSP Definition" })

vim.keymap.set('n', 'gT', function()
  pcall(vim.lsp.buf.type_definition)
end, { silent = true, desc = "LSP Type Definition" })

vim.keymap.set('n', 'gi', function()
  local ok, builtin = pcall(require, 'telescope.builtin')
  if ok then
    pcall(builtin.lsp_implementations)
  else
    pcall(vim.lsp.buf.implementation)
  end
end, { silent = true, desc = "LSP Implementation" })

vim.keymap.set('n', 'gr', function()
  local ok, builtin = pcall(require, 'telescope.builtin')
  if ok then
    pcall(builtin.lsp_references)
  else
    pcall(vim.lsp.buf.references)
  end
end, { silent = true, desc = "LSP References" })
```
