Neovim IME + Diagnostics — Working Notes

Goal
- Use any keyboard layout while coding:
  - Auto‑switch to English in Normal/Visual/Operator modes so all mappings work (hjkl, gd/gi/gr, <leader>…)
  - Restore the previous layout in Insert/Cmdline for natural typing
- Bonus done earlier: show per‑file diagnostics in Telescope file browser (<leader>fe and "-")

What’s implemented
- Plugin config: keaising/im-select.nvim (lua/plugins/im-select.lua)
  - Switch to English on InsertLeave/CmdlineLeave, restore on InsertEnter/CmdlineEnter
  - Helper commands: :IMSelectCurrent and :IMSelectSet <id>
- PATH bootstrap in init.lua to include Homebrew bins (/opt/homebrew/bin or /usr/local/bin)
- Diagnostics prefixes in Telescope file browser via lua/util/diag_prefix.lua

Current blocker
- im-select binary not installed (brew tap daipeihust/tap; brew install im-select) failed due to outdated Xcode Command Line Tools.

Next steps (when returning)
1) Update Command Line Tools (System Settings → Software Update or xcode-select --install)
2) Install im-select: brew tap daipeihust/tap && brew install im-select
3) Verify in Neovim: :echo executable('im-select') → 1
4) Confirm layout ID: from terminal, run `im-select` when English layout is active; set default_im_select accordingly in lua/plugins/im-select.lua
5) Test: Insert mode in Russian → <Esc> to Normal → :IMSelectCurrent should show English ID

Notes
- No langmap fallback is active (explicitly reverted). IME switching depends on im-select being present.

Find & Replace
- Project-wide UI: `<leader>sr` opens Spectre for search/replace across the repo.
- Current word: `<leader>sw` searches the word under cursor across the project; visual mode uses selection.
- File-only UI: `<leader>sf` opens Spectre scoped to current file.
