-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local lsp_utils = require("utils.lsp_utils")

-- stylua: ignore start

-- Add a keymap for toggling BasedPyright settings
vim.keymap.set("n", "<leader>ut", function() lsp_utils.toggle_basedpyright_settings() end, { desc = "Toggle BasedPyright Settings" })

-- Add some DAP mappings
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debugger: Start" })
vim.keymap.set("n", "<F6>", function() require("dap").pause() end, { desc = "Debugger: Pause" })
vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debugger: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debugger: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debugger: Step Into" })
vim.keymap.set("n", "<F17>", function() require("dap").terminate() end, { desc = "Debugger: Terminate" }) -- Shift+F5
vim.keymap.set("n", "<F23>", function() require("dap").step_out() end, { desc = "Debugger: Step Out" }) -- Shift+F11
-- stylua: ignore end
