# Neovim Config

Overview
- This repository is the active Neovim configuration.
- Entry point is `init.lua`, which bootstraps lazy.nvim, loads options/keymaps, then loads plugins.

Structure
- `init.lua` bootstraps lazy.nvim, adds Homebrew paths, loads `lua/vim-options.lua`, applies the colorscheme, and enables LSP core.
- `lua/vim-options.lua` holds editor options, custom keymaps, netrw tweaks, terminal behavior, and formatting hooks.
- `lua/lsp-core.lua` is the single LSP owner: it defines all LSP autostart via `vim.lsp.start`, root detection, and LSP keymaps.
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
- Git integrations with gitsigns, Diffview, Neogit, and git-conflict, plus Telescope git pickers.
- Git commit message template auto-fill from branch issue keys (e.g. `release/MYACC-12345` -> `[MYACC-12345] `).
- Formatting hooks for SQL and Kotlin, plus Go format-on-save for Go-related filetypes.
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
- Files: `<leader>nf` new file, `<leader>nd` new directory, `<leader>rf` rename file, `<leader>df` delete file, `<leader>yp` copy full path, `<leader>yr` copy relative path, `<leader>y` yank to system clipboard.
- Explorers: `<leader>fe` Telescope file browser at project root, `-` Telescope file browser at current file directory, `<leader>fE` netrw at project root, `<leader>-` netrw at current directory, `<leader>le` netrw left sidebar.
- Diagnostics: `<leader>d` all, `<leader>de` errors, `<leader>dw` warnings, `<leader>df` current file, `<leader>e` float or current-file list.
- LSP: `gd` definition, `gT` type definition, `gi` implementation, `gr` references, `<C-g>d` definition in new tab, `<C-g>i` implementation in new tab, `<C-g>r` references in new tab, `K` hover, `<leader>rn` rename, `<leader>ca` code action, `[d` and `]d` prev and next diagnostic, `<C-k>` signature help in insert mode.
- Git: `<leader>gg` Neogit status, `<leader>gG` Neogit status in vsplit, `<leader>gb` blame line, `<leader>hr` reset hunk, `<leader>gd` Diffview open, `<leader>gq` Diffview close, `<leader>gh` file history, `<leader>gH` repo history, `<leader>gc` git commits, `<leader>gC` buffer commits, `<leader>gs` git status.
- Conflicts: `]x` and `[x` next and previous conflict, `<leader>cm` open a picker menu for chunk resolution, `<leader>co` choose ours, `<leader>ct` choose theirs, `<leader>cb` choose both, `<leader>c0` choose none, `<leader>cq` list conflicts in quickfix, `<leader>cv` open merge diff view (auto-hides file panel for width), `<leader>cV` close merge diff view. Diffview merge mode defaults to `diff3_mixed`: top `OURS|THEIRS` references with a bottom full-width editable `LOCAL` pane. In Diffview use `<leader>b` to toggle file panel and `g<C-x>` to cycle layouts (including single-pane `diff1_plain`). Conflict sections use green (incoming) and red (current) backgrounds.
- Neogit status view labels unmerged file rows as `CONFLICT` with strong error highlighting to separate them from generic unstaged entries.
- Neogit status rows use compact mode tags (`MOD`, `NEW`, `ADD`, etc.) and neutral file-path highlighting so status labels and filenames are visually separated.
- Go: `<leader>gs` GoCoverage and `<leader>gS` GoCoverageClear in Go buffers (buffer-local override of global git status).
- Replace: `<leader>sp` project replace, `<leader>sf` file replace, `<leader>sw` search word (normal or visual).
- Coverage: `<leader>cl` load, `<leader>cs` show, `<leader>ch` hide, `<leader>cc` clear.
- Pounce: `s` and `S` in normal or operator-pending, `<C-s>` in insert.
- UI toggles: `<leader>m` mouse toggle, `<leader>th` theme picker, `<leader>tb` Gruvbox background picker.
- Reload: `<leader>R` reload files changed on disk.

Commands and toggles
- Mouse: `:MouseOn`, `:MouseOff`, `:MouseToggle`, `:MouseOffTemp [ms]`
- Scroll wheel cursor mode: `:ScrollCursorOn`, `:ScrollCursorOff`, `:ScrollCursorToggle`
- Horizontal mouse-wheel scrolling is disabled globally to avoid sideways movement on wrapped text.
- SQL format toggles: `:SqlFormatOnSaveEnable`, `:SqlFormatOnSaveDisable`, `:SqlFormatOnSaveToggle`, and global variants.

External tools and dependencies
- ripgrep (`rg`) is used by Telescope for file search and grep.
- LSP servers are started only from `lua/lsp-core.lua` via `vim.lsp.start`; Mason is used to install server binaries.
- SQL formatting expects a `sql_formatter` binary.
- Kotlin formatting expects `ktlint`.
- Go buffers use tab indentation via filetype-local options (`noexpandtab`, width 4).
- Go formatting runs on write (`:w`, `:wq`, UI save) for `go`, `gomod`, `gowork`, `gosum`, and `gotmpl`, preferring LSP and falling back to conform when available.

Notes
- `NOTES.md` documents keymap overlaps and other configuration caveats.
- Keymap migration: netrw moved from `<leader>fe` -> `<leader>fE` and `-` -> `<leader>-`; Gruvbox background picker moved from `<leader>gb` -> `<leader>tb`.
