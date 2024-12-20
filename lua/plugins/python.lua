return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure opts.servers exists
      opts.servers = opts.servers or {}

      -- Add or update the basedpyright server configuration
      opts.servers.basedpyright = {
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
                -- callArgumentNames = false,
                -- genericTypes = false,
              },
            },
          },
        },
      }
    end,
  },
}
