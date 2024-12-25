return {
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
}
