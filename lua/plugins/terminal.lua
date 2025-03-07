return {
  {
    "jabirali/vim-tmux-yank",
    event = "VeryLazy",
    config = function()
      vim.g.vim_tmux_yank_enable = 1
      -- vim.g.vim_tmux_yank_dont_overwrite_clipboard = 1
    end,
  },
}
