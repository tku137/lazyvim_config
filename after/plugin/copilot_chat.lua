-- This is a hack because for some reason merging the
-- opts table in lua/plugins/ai.lua did not change the
-- model used when the plugin is lazy-loaded.
-- Using this, we just manually set the model.
require("CopilotChat").setup({
  model = "claude-3.5-sonnet",
})
