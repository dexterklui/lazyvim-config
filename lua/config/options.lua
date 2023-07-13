-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set global variables
vim.g.markdown_folding = 1

-- Set vim options
vim.opt_global.path:append({ "**" }) -- allow :find and gf to fuzzy search with * at front
vim.opt.fillchars = { fold = " " } -- no more filling chars for folds
vim.opt.clipboard = "" -- Use vim register
vim.opt.wrap = true
vim.opt.scrolloff = 3 -- Lines of context
vim.opt.colorcolumn = "+1"
vim.opt.winwidth = 87 -- Set the min nr of columns for current window
vim.opt.showbreak = "∥" -- leading character that indicate a wrapped line
vim.opt.lcs = "tab:‹ ›,trail:·,eol:¬,nbsp:_" -- adjust the text printed by :list
vim.opt.list = true -- show "invisible" chars on screen like using :list
vim.opt.wrapscan = false -- disable search through bottom to top
vim.opt.spelllang = "en_gb" -- British english spell check
