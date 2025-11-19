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
    cmd = { "gopls", "-remote=auto" },
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
