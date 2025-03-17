return {
  {
    "jabirali/vim-tmux-yank",
    event = "VeryLazy",
    enabled = function()
      -- Only enable the plugin when in tmux
      -- Prevents the dreaded "no" file creation
      return vim.fn.exists("$TMUX") == 1
    end,
    config = function()
      vim.g.vim_tmux_yank_enable = 1
      vim.g.vim_tmux_yank_tmux_only = 1
    end,
  },
}
