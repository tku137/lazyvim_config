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
    },

    specs = {
      {
        "catppuccin",
        optional = true,
        opts = { integrations = { neogit = true } },
      },
    },
  },
  {
    "wintermute-cell/gitignore.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    config = function()
      local gitignore = require("gitignore")
      local fzf = require("fzf-lua")

      gitignore.generate = function(opts)
        local picker_opts = {
          prompt = "Select templates for gitignore file> ",
          winopts = {
            width = 0.4,
            height = 0.3,
          },
          -- Enable multi-selection
          fzf_opts = {
            ["--multi"] = "",
            ["--bind"] = "tab:toggle+down",
          },
          actions = {
            default = function(selected, _)
              gitignore.createGitignoreBuffer(opts.args, selected)
            end,
          },
        }

        fzf.fzf_exec(function(fzf_cb)
          for _, prefix in ipairs(gitignore.templateNames) do
            fzf_cb(prefix)
          end
          fzf_cb()
        end, picker_opts)
      end

      vim.api.nvim_create_user_command("Gitignore", gitignore.generate, {
        nargs = "?",
        complete = "file",
      })
    end,
    keys = {
      { "<leader>ci", mode = "n", desc = "Generate .gitignore", "<cmd>Gitignore<cr>" },
    },
  },
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
