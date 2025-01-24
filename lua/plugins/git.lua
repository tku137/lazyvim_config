local prefix = "<Leader>g"
return {
  {
    "NeogitOrg/neogit",
    lazy = true,
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
    lazy = true,
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      local gitignore = require("gitignore")

      gitignore.generate = function(opts)
        Snacks.picker({
          items = vim.tbl_map(function(name)
            return {
              id = name,
              text = name,
              file = name,
            }
          end, gitignore.templateNames),
          preview = "text",
          title = "Select templates for .gitignore file",
          layout = {
            preview = false,
          },
          confirm = function(picker)
            local selected = picker:selected({ fallback = true })
            if selected and #selected > 0 then
              local templates = vim.tbl_map(function(item)
                return item.id
              end, selected)
              picker:close()
              gitignore.createGitignoreBuffer(opts.args, templates)
            end
            picker:close()
          end,
        })
      end

      vim.api.nvim_create_user_command("Gitignore", gitignore.generate, {
        nargs = "?",
        complete = "file",
      })
    end,
    keys = {
      { "<leader>gi", mode = "n", desc = "Generate .gitignore", "<cmd>Gitignore<cr>" },
    },
  },
  {
    "SuperBo/fugit2.nvim",
    lazy = true,
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
