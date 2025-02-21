local M = {}

--- Toggle BasedPyright typeCheckingMode and inlay hints
function M.toggle_basedpyright_settings(opts)
  opts = opts or {}

  -- Get the LSP client for basedpyright
  local client = vim.lsp.get_clients({ name = "basedpyright" })[1]
  if not client then
    vim.notify("BasedPyright LSP is not active", vim.log.levels.WARN)
    return
  end

  -- Toggle the typeCheckingMode
  local analysis = client.config.settings.basedpyright.analysis
  if analysis.typeCheckingMode == "basic" then
    analysis.typeCheckingMode = "recommended"
  else
    analysis.typeCheckingMode = "basic"
  end

  -- Toggle the inlayHints settings
  local hints = analysis.inlayHints
  hints.variableTypes = not hints.variableTypes
  hints.functionReturnTypes = not hints.functionReturnTypes
  hints.callArgumentNames = not hints.callArgumentNames

  -- Restart the LSP to apply changes
  vim.lsp.stop_client(client.id)
  vim.defer_fn(function()
    vim.cmd("LspStart basedpyright")
    if not opts.silent then
      vim.notify(
        "BasedPyright restarted with typeCheckingMode: "
          .. analysis.typeCheckingMode
          .. "\nInlay Hints: "
          .. (hints.variableTypes and "enabled" or "disabled")
      )
    end
  end, 100)
end

return M
