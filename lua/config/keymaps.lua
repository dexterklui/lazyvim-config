-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.cmd.command({ "Master", "e ~/master.dqn" })

-- To close live-server, execute something like `:bd term*live`
vim.cmd.command({ "Live", "vsp term://live-server | close" })
