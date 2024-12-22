return {
  -- {
  --   "LiadOz/nvim-dap-repl-highlights",
  --   lazy = true,
  --   ft = "dap-repl",
  --   specs = {
  --     {
  --       "nvim-treesitter/nvim-treesitter",
  --       dependencies = {
  --         "LiadOz/nvim-dap-repl-highlights",
  --         dependencies = { "mfussenegger/nvim-dap" },
  --         opts = {},
  --       },
  --       opts = { ensure_installed = { "dap_repl" } },
  --     },
  --   },
  -- },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      commented = true,
      enabled = true,
      enabled_commands = true,
    },
    lazy = true,
  },
}
