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
