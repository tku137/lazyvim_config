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

------------------------------------------------------------
-- Helper Functions
------------------------------------------------------------

-- Search for a given pattern in the first 'max_lines' of the buffer (performance consideration).
-- This can be used for an import pattern in a markup file type, but potentially also for other patterns in any file type.
local function find_pattern_in_buffer(max_lines, pattern)
  local lines = vim.api.nvim_buf_get_lines(0, 0, max_lines, false)
  for _, line in ipairs(lines) do
    if line:match(pattern) then
      return true
    end
  end
  return false
end

-- Read the first n lines from a file at 'filepath'
local function read_lines_from_file(filepath, n)
  local ok, lines = pcall(vim.fn.readfile, filepath)
  if not ok or not lines then
    return {}
  end
  local result = {}
  for i = 1, math.min(n, #lines) do
    table.insert(result, lines[i])
  end
  return result
end

-- Search for a given pattern in a table of lines.
local function find_pattern_in_lines(lines, pattern)
  for _, line in ipairs(lines) do
    if line:match(pattern) then
      return true
    end
  end
  return false
end

------------------------------------------------------------
-- Main File Detection for TypSet Systems
------------------------------------------------------------

function M.get_tinymist_main_file()
  -- Try to retrieve the main file from tinymist LSP client
  local current_buf = vim.api.nvim_get_current_buf()
  local tinymist_main = nil

  -- Send a synchronous LSP request to get the pinned main file.
  local response = vim.lsp.buf_request_sync(current_buf, "workspace/executeCommand", {
    command = "tinymist.getMain",
    arguments = {},
  }, 1000)
  if response then
    for _, res in pairs(response) do
      if res.result and type(res.result) == "string" and res.result ~= "" then
        tinymist_main = res.result
        break
      end
    end
  end

  if tinymist_main then
    return tinymist_main
  end

  -- Fallback: return the current buffer's filename if no main file is pinned
  return vim.api.nvim_buf_get_name(current_buf)
end

function M.get_vimtex_main_file()
  -- Check if VimTeX has a main file defined
  if vim.g.vimtex and vim.g.vimtex.main and vim.fn.filereadable(vim.g.vimtex.main) == 1 then
    return vim.g.vimtex.main
  end

  -- Fallback: return the current buffer's filename if no main file is pinned
  local current_buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_name(current_buf)
end

------------------------------------------------------------
-- Spell Language Application for Each File Type
------------------------------------------------------------

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
