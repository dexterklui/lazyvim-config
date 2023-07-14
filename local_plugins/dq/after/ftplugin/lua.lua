vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

local undo_ftplugin = "| setl ts< sw<"
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. undo_ftplugin
