-- Plugin loading guards
if _G.LOADED_PRY then
  return
end

if vim.o.cp then
  return
end

_G.LOADED_PRY = true

local pry_map = {
  ruby = "binding.pry",
  javascript = "debugger;",
  ["javascript.jsx"] = "debugger;", -- Using ["key"] for keys with dots
  typescript = "debugger;",
  vue = "debugger;",
  ["html.handlebars"] = "{{debugger}}", -- Using ["key"] for keys with dots
  php = "eval(\\Psy\\sh());", -- Escaping backslashes for Lua string
  python = "import pdb; pdb.set_trace()",
}

local M = {}

function M.insert()
  local filetype = vim.bo.filetype
  local text_to_insert = pry_map[filetype]

  if text_to_insert then
    vim.cmd("normal! o") -- Open a new line below and enter insert mode
    vim.api.nvim_paste(text_to_insert, true, -1) -- Paste the text, true for linewise, -1 for all lines
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false) -- Return to normal mode
  else
    vim.notify("No pry mapping defined for filetype: " .. filetype, vim.log.levels.WARN)
  end
end

vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua require("pry").insert()<CR>', { noremap = true, silent = true })

return M
