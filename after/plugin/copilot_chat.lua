-- This is a hack because for some reason merging the
-- opts table in lua/plugins/ai.lua did not change the
-- model used when the plugin is lazy-loaded.
-- Using this, we just manually set the model.
local current_config = require("CopilotChat").config
local new_config = vim.tbl_deep_extend("force", current_config or {}, {
  model = "claude-3.5-sonnet",
})
require("CopilotChat").setup(new_config)
