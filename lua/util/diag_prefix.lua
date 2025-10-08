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
