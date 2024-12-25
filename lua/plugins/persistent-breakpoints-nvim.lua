return {
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
}
