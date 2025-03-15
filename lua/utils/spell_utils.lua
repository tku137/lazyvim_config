local M = {}

-- Global flag for auto spell language switching (default is enabled)
local auto_spell_switch_enabled = true

-- Toggle the spell language auto switching on/off
function M.toggle()
  auto_spell_switch_enabled = not auto_spell_switch_enabled
end

-- Return the current state of auto spell language switching
function M.is_enabled()
  return auto_spell_switch_enabled
end

--
-- Helper function: Search for a given pattern in the first 'max_lines'
-- of the buffer (performance consideration).
-- This can be used for an import pattern in a markup file type, but
-- potentially also for other patterns in any file type.
local function find_pattern_in_buffer(max_lines, pattern)
  local lines = vim.api.nvim_buf_get_lines(0, 0, max_lines, false)
  for _, line in ipairs(lines) do
    if line:match(pattern) then
      return true
    end
  end
  return false
end

-- Apply the appropriate spell language based on file type and file content.
-- For ".typ" files, the first 10 lines are scanned for '#set text(lang: "de")'.
-- For ".tex" files, the first 25 lines are scanned for a \usepackage[...] entry with german options.
-- Defaults to "en_us". If the current spell language already matches, no action is taken.
function M.apply_spell_language()
  if not auto_spell_switch_enabled then
    return
  end

  local ext = vim.fn.expand("%:e")
  local desired_lang = "en_us" -- default language if no match is found

  if ext == "typ" then
    -- This pattern matches the line:
    -- #set text(lang: "de")
    local typ_de_pattern = '#set%s+text%(lang:%s*"de"%s*%)'
    if find_pattern_in_buffer(10, typ_de_pattern) then
      desired_lang = "de_de"
    end
  elseif ext == "tex" then
    -- This pattern matches lines like:
    -- \usepackage[...german...]{babel} or \usepackage[...ngerman...]{babel}
    local tex_pattern = "\\usepackage%[[^%]]*n?german[^%]]*%]{babel}"
    if find_pattern_in_buffer(25, tex_pattern) then
      desired_lang = "de_de"
    end
  end

  -- If the desired language is already active, do nothing
  if vim.bo.spelllang == desired_lang then
    return
  end

  -- Otherwise, set the spell language
  vim.cmd("setlocal spell spelllang=" .. desired_lang)
  vim.notify("Activated " .. desired_lang .. " language for spell checking.")
end

return M
