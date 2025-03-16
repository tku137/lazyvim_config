local function spell_status()
  if vim.wo.spell then
    local langs = vim.bo.spelllang or ""
    langs = vim.trim(langs)
    if langs ~= "" then
      local tbl = vim.split(langs, ",", { trimempty = true })
      local en_present = false
      local de_present = false
      for _, lang in ipairs(tbl) do
        if lang == "en" or lang == "en_us" then
          en_present = true
        end
        if lang == "de" or lang == "de_de" then
          de_present = true
        end
      end
      if en_present and de_present then
        return "ok"
      elseif en_present or de_present then
        return "pending"
      end
    end
  end
  return nil
end

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.status(" ", spell_status))
    end,
  },
}
