local prefix = "<Leader>g"
return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        prefix .. "n",
        "<Cmd>Neogit<CR>",
        desc = "Open Neogit Tab Page",
        mode = "n",
      },
      -- {
      --   prefix .. "Nc",
      --   "<Cmd>Neogit commit<CR>",
      --   desc = "Open Neogit Commit Page",
      --   mode = "n",
      -- },
      -- {
      --   prefix .. "Nd",
      --   "<Cmd>Neogit cwd<CR>",
      --   desc = "Open Neogit Override CWD",
      --   mode = "n",
      -- },
      -- {
      --   prefix .. "nk",
      --   "<Cmd>Neogit kind<CR>",
      --   desc = "Open Neogit Override Kind",
      --   mode = "n",
      -- },
    },

    specs = {
      {
        "catppuccin",
        optional = true,
        opts = { integrations = { neogit = true } },
      },
    },
  },
}
