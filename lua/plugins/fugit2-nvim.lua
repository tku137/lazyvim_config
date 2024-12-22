return {
  {
    "SuperBo/fugit2.nvim",
    opts = {
      width = 100,
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      {
        "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
      },
    },
    cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
    keys = {
      { "<leader>gf", mode = "n", desc = "Fugit2", "<cmd>Fugit2<cr>" },
    },
  },
}
