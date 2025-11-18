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

