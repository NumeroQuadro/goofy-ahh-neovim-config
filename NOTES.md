Neovim Config — Notes

Scope
- This repo is the active Neovim config loaded by `init.lua`.
- Documentation focuses on config behavior, not helper tooling.

Keymap ownership
- `<leader>fe` and `-` are owned by Telescope file_browser (`lua/plugins/telescope.lua`).
- Netrw explorer keys are intentionally secondary: `<leader>fE` (project root), `<leader>-` (current directory), and `<leader>le` (left sidebar) in `lua/vim-options.lua`.
- `<leader>gb` is owned by gitsigns blame (`lua/plugins/gitsigns.lua`); Gruvbox background picker moved to `<leader>tb` in `lua/vim-options.lua`.
- `<leader>gs` is global Git status (`lua/plugins/telescope.lua`); Go coverage uses buffer-local overrides in Go filetypes only (`lua/plugins/ray-x.lua`).
- Horizontal mouse-wheel gestures are disabled globally; wrapped text should not trigger sideways viewport shifts.

Formatting behavior
- SQL format-on-save uses `conform.nvim` (`sql_formatter`). Toggle with `:SqlFormatOnSave*` commands.
- Kotlin format-on-save uses `conform.nvim` (`ktlint`).
- Go buffers use filetype-local tabs (`noexpandtab`, `tabstop=4`, `softtabstop=4`, `shiftwidth=4`) for `go`, `gomod`, `gowork`, `gosum`, and `gotmpl`.
- Go formatting runs in `BufWritePre` for normal save paths (`:w`, `:wq`, and UI save), preferring an attached LSP formatter and otherwise trying conform quietly.
- Caveat: if no Go LSP is attached and no conform formatter is available for that buffer, the write still succeeds without formatting.

Commit message template
- For `gitcommit` buffers, the first line is auto-filled as `[ISSUE-123] ` when the current branch contains an issue key (prefers `MYACC-T<digits>`, then `MYACC-<digits>`).
- Existing non-empty commit messages are not overwritten (e.g. merge/rebase generated messages).

Git workflow
- Neogit is the primary status UI (`<leader>gg` and `<leader>gG`) with Diffview and Telescope integrations enabled.
- Neogit keeps unmerged files inside `Unstaged changes` by design; to make this clearer, conflict labels are rendered as `CONFLICT` and highlighted with error colors.
- Neogit mode labels are compact (`MOD`, `NEW`, `ADD`, etc.) with wider mode-column padding and neutral `NeogitFilePath` coloring to improve filename readability in long lists.
- Diffview uses enhanced diff highlighting for colorized side-by-side review.
- Diffview merge mode is set to `diff3_mixed`: top `OURS | THEIRS` references with a bottom full-width editable `LOCAL` pane.
- In Diffview merge mode, `<leader>cv` auto-hides the file panel for maximum width; use `<leader>b` to toggle it back when needed.
- In Diffview merge mode, press `g<C-x>` to cycle layouts if you want single-pane marker editing (`diff1_plain`) or other merge layouts.
- Diffview buffers use local-only compact gutters (`nonumber`, `norelativenumber`, `signcolumn=no`, `foldcolumn=0`) to improve visibility without changing global options.
- Merge-conflict gestures are `]x` and `[x` (next and previous), with `<leader>co`, `<leader>ct`, `<leader>cb`, and `<leader>c0` for ours, theirs, both, and none.
- `<leader>cm` opens a conflict picker menu (choose ours/theirs/both/none and auto-jump to next conflict).
- `<leader>cq` opens conflict locations in quickfix.
- `<leader>cv` opens Diffview merge mode and `<leader>cV` closes it.
- Conflict sections are highlighted as green for incoming and red for current changes (no yellow `DiffText` section).
- LSP autostart and git-conflict overlays are skipped for non-file URI buffers (for example `diffview://...`) to avoid gopls URI parse errors and git-conflict extmark range errors in Diffview.

Diagnostics prefixes in Telescope
- Telescope file_browser shows diagnostic counts only for already-open buffers (see `lua/util/diag_prefix.lua`).

LSP setup
- LSP autostart is defined only in `lua/lsp-core.lua` via `vim.lsp.start`.
- `lua/plugins/lsp-config.lua` keeps Mason + mason-lspconfig `ensure_installed` only (install management, no client startup).
- Mason ensures several servers are installed; only the servers defined in `lua/lsp-core.lua` are started.
- `gopls` does not auto-enable inlay hints to avoid repeated `InlayHint` metadata errors in some Go workspaces.
