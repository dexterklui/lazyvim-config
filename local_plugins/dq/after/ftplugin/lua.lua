vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

-- Mini snippet
vim.keymap.set("i", "{", function()
  local node = vim.treesitter.get_node()
  local nodes_active_in = { "table_constructor" }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    if MiniPairs == nil then
      return "{"
    end
    local result = MiniPairs.open("{}", "[^\\].")
    return result == "{" and "{" or "{}<Left>"
  end
  return "{},<Left><Left>"
end, { expr = true, buffer = true, noremap = true })

local undo_ftplugin = "| setl ts< sw<"
undo_ftplugin = undo_ftplugin .. "| iunmap <buffer> {"
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. undo_ftplugin
