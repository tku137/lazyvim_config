local prefix = "<Leader>cr"

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
                callArgumentNames = false,
                -- genericTypes = false,
              },
            },
          },
        },
      }
    end,
  },
  {
    "geg2102/nvim-python-repl",
    dependencies = {
      "nvim-treesitter",
    },
    keys = {
      -- Normal mode keymaps
      {
        prefix .. "r",
        function()
          require("nvim-python-repl").send_statement_definition()
        end,
        desc = "Send semantic unit to REPL",
        mode = "n",
      },
      {
        "<Leader>r",
        function()
          require("nvim-python-repl").send_statement_definition()
        end,
        desc = "Send semantic unit to REPL",
        mode = "n",
      },
      {
        prefix .. "b",
        function()
          require("nvim-python-repl").send_buffer_to_repl()
        end,
        desc = "Send entire buffer to REPL",
        mode = "n",
      },
      {
        prefix .. "E",
        function()
          require("nvim-python-repl").toggle_execute()
          vim.notify(
            "Automatic REPL execution "
              .. (require("nvim-python-repl.config").defaults["execute_on_send"] and "Enabled" or "Disabled")
          )
        end,
        desc = "Toggle automatic execution",
        mode = "n",
      },
      {
        prefix .. "V",
        function()
          require("nvim-python-repl").toggle_vertical()
          vim.notify(
            "REPL split set to "
              .. (require("nvim-python-repl.config").defaults["vsplit"] and "Vertical" or "Horizontal")
          )
        end,
        desc = "Toggle vertical/horizontal split",
        mode = "n",
      },
      -- Visual mode keymaps
      {
        "<Leader>r",
        function()
          require("nvim-python-repl").send_visual_to_repl()
        end,
        desc = "Send visual selection to REPL",
        mode = "v",
      },
    },
    ft = { "python", "lua", "scala" },
    config = function()
      require("nvim-python-repl").setup({
        execute_on_send = true,
        vsplit = true,
        spawn_command = {
          python = "ipython",
          scala = "sbt console",
          lua = "ilua",
        },
      })
    end,
  },
}
