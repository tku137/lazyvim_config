return {
  {
    "LiadOz/nvim-dap-repl-highlights",
    enabled = false,
    lazy = true,
    ft = "dap-repl",
    specs = {
      {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
          "LiadOz/nvim-dap-repl-highlights",
          dependencies = { "mfussenegger/nvim-dap" },
          opts = {},
        },
        opts = { ensure_installed = { "dap_repl" } },
      },
    },
  },
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
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
    keys = {
      {
        "<Leader>db",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        { silent = true },
        desc = "Toggle Breakpoint",
      },
      {
        "<Leader>dx",
        function()
          require("persistent-breakpoints.api").clear_all_breakpoints()
        end,
        { silent = true },
        desc = "Clear Breakpoints",
      },
      {
        "<Leader>dB",
        function()
          require("persistent-breakpoints.api").set_conditional_breakpoint()
        end,
        { silent = true },
        desc = "Conditional Breakpoint",
      },
    },
  },
}
