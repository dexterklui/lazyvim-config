-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local dq_aug = vim.api.nvim_create_augroup("dqAugVimrc", {})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = dq_aug,
  pattern = "term://*",
  command = "startinsert",
  desc = "Enter insert mode when creating a term buffer",
})
