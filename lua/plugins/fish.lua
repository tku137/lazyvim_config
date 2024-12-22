return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "fish" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
      },
    },
  },
}
