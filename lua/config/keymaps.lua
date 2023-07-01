-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.cmd.command({ "Master", "e ~/master.dqn" })

-- To close live-server, execute something like `:bd term*live`
vim.cmd.command({ "Live", "vsp term://live-server | close" })

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
map("n", "<m-j>", "<plug>(VM-Add-Cursor-Down)", { desc = "Add multi cursor down" })
map("n", "<m-k>", "<plug>(VM-Add-Cursor-Up)", { desc = "Add multi cursor up" })
map("n", "<m-s-h>", "<plug>(VM-Select-h)", { desc = "Multi select left" })
map("n", "<m-s-l>", "<plug>(VM-Select-l)", { desc = "Multi select right" })
