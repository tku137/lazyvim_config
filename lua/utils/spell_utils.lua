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
-- Caching Setup
------------------------------------------------------------
local main_file_cache = setmetatable({}, { __mode = "kv" })

-- Automatic cache invalidation when a buffer is deleted or wiped out.
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  callback = function(args)
    main_file_cache[args.buf] = nil
  end,
})

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
  -- Sanity check: return an empty table if the file does not exist
  if vim.fn.filereadable(filepath) ~= 1 then
    return {}
  end
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

-- Check if a filepath is already the current buffer
local function is_current_buffer(filepath)
  return vim.api.nvim_buf_get_name(0) == filepath
end

------------------------------------------------------------
-- Main File Detection for TypSet Systems
------------------------------------------------------------

function M.get_tinymist_main_file()
  -- Try to retrieve the main file from tinymist LSP client
  local current_buf = vim.api.nvim_get_current_buf()

  -- Check if the main file is already cached
  if main_file_cache[current_buf] then
    return main_file_cache[current_buf]
  end

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
    -- Update the cache and return the main file
    main_file_cache[current_buf] = tinymist_main
    return tinymist_main
  end

  -- Fallback: return the current buffer's filename if no main file is pinned
  local fallback = vim.api.nvim_buf_get_name(current_buf)
  main_file_cache[current_buf] = fallback
  return fallback
end

function M.get_vimtex_main_file()
  -- Fallback: return the current buffer's filename if no main file is pinned
  local current_buf = vim.api.nvim_get_current_buf()

  -- Check if the main file is already cached
  if main_file_cache[current_buf] then
    return main_file_cache[current_buf]
  end

  local vimtex_main = nil
  -- Check if VimTeX has a main file defined
  if vim.g.vimtex and vim.g.vimtex.main and vim.fn.filereadable(vim.g.vimtex.main) == 1 then
    vimtex_main = vim.g.vimtex.main
  else
    vimtex_main = vim.api.nvim_buf_get_name(current_buf)
  end

  main_file_cache[current_buf] = vimtex_main
  return vimtex_main
end

------------------------------------------------------------
-- Spell Language Application for Each File Type
------------------------------------------------------------

-- Apply the appropriate spell language based on file type and file content.
function M.apply_spell_language(main_file, pattern, header_lines, desired_lang, default_lang)
  if not auto_spell_switch_enabled then
    return
  end
  default_lang = default_lang or "en"

  -- Since we distinguish between file types in the autocmds, we can assume that the file type is correct here.
  -- However, it could still be that main_file is nil, so we need to handle that case.
  local lines = {}
  if main_file and not is_current_buffer(main_file) then
    lines = read_lines_from_file(main_file, header_lines)
  else
    lines = vim.api.nvim_buf_get_lines(0, 0, header_lines, false)
  end

  if find_pattern_in_lines(lines, pattern) then
    -- If the desired language is already active, do nothing
    if vim.bo.spelllang == desired_lang then
      return
    end

    -- Otherwise, set the spell language
    vim.cmd("setlocal spell spelllang=" .. desired_lang)
    vim.notify("Activated " .. desired_lang .. " language for spell checking.")
  else
    vim.cmd("setlocal spell spelllang=" .. default_lang)
    vim.notify("Activated " .. default_lang .. " language for spell checking.")
  end
end

return M
