return {
  {
    "OXY2DEV/helpview.nvim",
    lazy = true,
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = { ensure_installed = { "vimdoc" } },
    },
  },
}
