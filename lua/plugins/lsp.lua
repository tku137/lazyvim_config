-- Define a list of extra schema file paths.
local yaml_schema_files = {
  vim.fn.getcwd() .. "/.yamlls.extra.lua",
  -- Add more file paths as needed.
  -- Make sure to use absolute paths! Otherwise CWD is assumed as base-dir!
}

-- Load and merge the schemas from all these files.
local yaml_extra_schemas = require("utils.lsp_utils").load_schema_files(yaml_schema_files)

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure opts.servers exists
      opts.servers = opts.servers or {}

      -- Add or update the basedpyright server configuration
      opts.servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              -- disableTaggedHints = true, -- Disables inline type hint comments
              analysis = {
                typeCheckingMode = "basic", -- possible values: "off", "basic", "strict"
                -- diagnosticSeverityOverrides = {
                --   reportUnknownParameterType = "none",
                --   reportMissingParameterType = "none",
                --   reportUnknownVariableType = "none",
                -- },
                inlayHints = {
                  variableTypes = false,
                  functionReturnTypes = false,
                  callArgumentNames = false,
                  -- genericTypes = false,
                },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = require("schemastore").yaml.schemas({
                extra = yaml_extra_schemas,
              }),
              -- there is a toggle keymap in case the official
              -- schemastore validation clashes with your custom one
              schemaStore = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
}
