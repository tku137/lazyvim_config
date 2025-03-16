-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Open dashboard when no buffers remain
vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("DashboardOnEmpty", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- Filter for valid and listed buffers with names
      local bufs = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ""
      end, vim.api.nvim_list_bufs())

      -- Open the snacks.dashboard if no buffers remain
      if #bufs == 0 then
        ---@diagnostic disable-next-line: missing-fields
        require("snacks.dashboard").open({
          win = vim.api.nvim_get_current_win(),
        })
      end
    end)
  end,
})

-- Navigate terminal with C-hjkl
local term_augroup = vim.api.nvim_create_augroup("TerminalMappings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = term_augroup,
  callback = function()
    local opts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end,
})

-- Automatically set spellchecking languages for certain text files
-- Create an autocommand for both .typ and .tex files that calls the apply_spell_language() function.
-- Search for pattern in n header lines and set desired lang if pattern is present
-- with respect to pinned main file
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.tex" },
  callback = function()
    local tex_pattern = "\\usepackage%[[^%]]*n?german[^%]]*%]{babel}"
    local header_lines = 25
    local desired_lang = "de,en"
    local main_file = require("utils.spell_utils").get_vimtex_main_file()
    require("utils.spell_utils").apply_spell_language(main_file, tex_pattern, header_lines, desired_lang)
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.typ" },
  callback = function()
    local typ_pattern = '#set%s+text%(lang:%s*"de"%s*%)'
    local header_lines = 10
    local desired_lang = "de,en"
    local main_file = require("utils.spell_utils").get_tinymist_main_file()
    require("utils.spell_utils").apply_spell_language(main_file, typ_pattern, header_lines, desired_lang)
  end,
})
