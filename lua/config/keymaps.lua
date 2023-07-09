-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_user_command("Master", "e ~/master.dqn", { desc = "edit ~/master.dqn" })

-- To close live-server, execute something like `:bd term*live`
vim.api.nvim_create_user_command("Live", "vsp term://live-server | set bh=hide | close", {
  desc = [[Create a terminal buffer in the background to run live-server in cwd.
To close live-server, you may try something like `:bd term*live`]],
})

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
local difforig_desc = "Diffsplit to see unsaved changes"
vim.api.nvim_create_user_command(
  "DiffOrig",
  "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis",
  { desc = difforig_desc }
)

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
map("n", "<Leader>fd", "<cmd>DiffOrig<CR>", { desc = difforig_desc })
