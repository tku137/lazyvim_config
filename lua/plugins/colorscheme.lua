return {
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" }, -- moon, stomr, night, day
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = "tokyonight",
    },
  },
}
