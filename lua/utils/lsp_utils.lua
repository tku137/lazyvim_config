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

-- Toggle yamlls schemaStore.enable setting
function M.toggle_yaml_schema_store(opts)
  opts = opts or {}

  -- Get the YAML LSP client for yamlls
  local client = vim.lsp.get_clients({ name = "yamlls" })[1]
  if not client then
    vim.notify("YAML LSP is not active", vim.log.levels.WARN)
    return
  end

  -- Toggle the schemaStore.enable setting
  local schemaStore = client.config.settings.yaml.schemaStore
  schemaStore.enable = not schemaStore.enable

  -- Restart the LSP to apply changes
  vim.lsp.stop_client(client.id)
  vim.defer_fn(function()
    vim.cmd("LspStart yamlls")
    if not opts.silent then
      vim.notify("YAML LSP restarted with schemaStore.enable = " .. tostring(schemaStore.enable))
    end
  end, 100)
end

-- Loads and merges extra schema files from a list.
-- 'files' is a list of absolute file paths.
-- 'default_base' is the fallback base directory for relative URLs.
function M.load_schema_files(files, default_base)
  default_base = default_base or vim.fn.getcwd()
  local schemas = {}
  for _, file in ipairs(files) do
    ---@diagnostic disable: undefined-field
    if vim.loop.fs_stat(file) then
      local ok, result = pcall(dofile, file)
      if ok and type(result) == "table" then
        for _, schema in ipairs(result) do
          -- Convert relative URLs to absolute file URIs.
          if schema.url and schema.url:sub(1, 1) == "." then
            local relative_path = schema.url:sub(3) -- remove "./"
            schema.url = "file://" .. default_base .. "/" .. relative_path
          end
          table.insert(schemas, schema)
        end
      end
    end
  end
  return schemas
end

return M
