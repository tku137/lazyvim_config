-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- stylua: ignore start

-- Add a keymap for toggling BasedPyright settings
-- This toggles BasedPyright's typeCheckingMode between "basic" and "recommended"
-- and additionally enables/disables inlay hints
Snacks.toggle
  .new({
    name = "BasedPyright Strict Mode",
    get = function()
      local client = vim.lsp.get_clients({ name = "basedpyright" })[1]
      return client
        and client.config.settings.basedpyright.analysis.typeCheckingMode == "recommended"
    end,
    set = function(_)
      require("utils.lsp_utils").toggle_basedpyright_settings({ silent = true })
    end,
  })
  :map("<leader>uP")


-- Add a keympa to toggle yamlls using schemastore or not
Snacks.toggle
  .new({
    name = "YAML SchemaStore Toggle",
    get = function()
      local client = vim.lsp.get_clients({ name = "yamlls" })[1]
      return client and client.config.settings.yaml.schemaStore.enable
    end,
    set = function(_)
      require("utils.lsp_utils").toggle_yaml_schema_store({ silent = true })
    end,
  })
  :map("<leader>uy")


-- Toggle automatic spell checker language switching
Snacks.toggle
  .new({
    name = "Spell Language Auto Switching",
    get = function()
      return require("utils.spell_utils").is_enabled()
    end,
    set = function(_)
      require("utils.spell_utils").toggle()
    end,
  })
  :map("<leader>uk")

-- Add some DAP mappings
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debugger: Start" })
vim.keymap.set("n", "<F6>", function() require("dap").pause() end, { desc = "Debugger: Pause" })
vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debugger: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debugger: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debugger: Step Into" })
vim.keymap.set("n", "<F17>", function() require("dap").terminate() end, { desc = "Debugger: Terminate" }) -- Shift+F5
vim.keymap.set("n", "<F23>", function() require("dap").step_out() end, { desc = "Debugger: Step Out" }) -- Shift+F11
-- stylua: ignore end
