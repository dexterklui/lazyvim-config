-- Add `,` automatically when adding new line
vim.keymap.set("n", "o", function()
  local line = vim.api.nvim_get_current_line()

  local should_add_comma = string.find(line, "[^,{[]$")
  if should_add_comma then
    return "A,<cr>"
  else
    return "o"
  end
end, { buffer = true, expr = true })

vim.keymap.set("n", "O", function()
  local line_nr = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.fn.getline(line_nr - 1)

  local should_add_comma = string.find(line, "[^,{[]$")
  if should_add_comma then
    return "kA,<cr>"
  else
    return "O"
  end
end, { buffer = true, expr = true })
