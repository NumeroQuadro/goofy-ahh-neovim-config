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
