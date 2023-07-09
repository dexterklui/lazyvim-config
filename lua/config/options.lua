-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.markdown_folding = 1

vim.opt_global.path:append({ "**" })
vim.opt.fillchars = { fold = " " }
vim.opt.clipboard = "" -- Use vim register
vim.opt.wrap = true
vim.opt.colorcolumn = "+1"
vim.opt.showbreak = "∥"
vim.opt.lcs = "tab:‹ ›,trail:·,eol:¬,nbsp:_" -- adjust the text printed by :list
vim.opt.list = true
vim.opt.hidden = false -- Such that a buffer is unloaded (no .swp) when abandoned
