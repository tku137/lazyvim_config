-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local lsp_utils = require("utils.lsp_utils")

-- stylua: ignore start

-- Add a keymap for toggling BasedPyright settings
vim.keymap.set("n", "<leader>ut", function() lsp_utils.toggle_basedpyright_settings() end, { desc = "Toggle BasedPyright Settings" })

-- stylua: ignore end
