return {
  -- Language support extras
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.tex" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  -- Editor and coding extras
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  { import = "lazyvim.plugins.extras.editor.snacks_picker" },
  { import = "lazyvim.plugins.extras.util.project" },
  -- { import = "lazyvim.plugins.extras.editor.outline" },
  -- { import = "lazyvim.plugins.extras.editor.refactoring" },

  -- Git extras
  { import = "lazyvim.plugins.extras.editor.mini-diff" },

  -- AI-related extras
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },

  -- Debugging and testing extras
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },
}
