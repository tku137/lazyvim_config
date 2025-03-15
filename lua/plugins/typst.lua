return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "tinymist" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "tinymist" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },
  {
    "kaarmu/typst.vim",
    ft = { "typst" },
    keys = {
      {
        "<localleader>c",
        ft = "typst",
        "<cmd>make<cr>",
        desc = "Compile Document",
      },
      {
        "<localleader>w",
        ft = "typst",
        "<cmd>TypstWatch<cr>",
        desc = "Typst Watch",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          keys = {
            {
              "<localleader>m",
              function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                for _, client in ipairs(clients) do
                  if client.name == "tinymist" then
                    client.request(
                      "workspace/executeCommand",
                      { command = "tinymist.pinMain", arguments = { buf_name } },
                      function(err, _, _)
                        if err then
                          print("Error: " .. err.message)
                        else
                          print("Main file pinned.")
                        end
                      end
                    )
                    break
                  end
                end
              end,
              desc = "Pin main file",
            },
          },
          single_file_support = true,
          settings = {
            formatterMode = "typstyle",
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle", lsp_format = "prefer" },
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
    keys = {
      {
        "<localleader>p",
        ft = "typst",
        "<cmd>TypstPreview<cr>",
        desc = "Typst Preview",
      },
      {
        "<localleader>P",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Toggle Typst Preview",
      },
    },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    },
  },
}
