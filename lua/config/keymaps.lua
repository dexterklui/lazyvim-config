-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- function and variables definition {{{1
--------------------------------------------------
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
local which_key = require("which-key")
local keydel = vim.keymap.del

-- User Commands {{{1
--------------------------------------------------
vim.api.nvim_create_user_command("Master", "e ~/master.dqn", { desc = "edit ~/master.dqn" })

-- Run live-server. To terminate it, execute something like `:bd term*live`
vim.api.nvim_create_user_command("Live", "vsp term://live-server | set bh=hide | close", {
  desc = [[Create a terminal buffer in the background to run live-server in cwd.
To close live-server, you may try something like `:bd term*live`]],
})

-- Diffsplit the current buffer with the original file (see unsaved changes)
local difforig_desc = "Diffsplit to see unsaved changes"
vim.api.nvim_create_user_command(
  "DiffOrig",
  "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis",
  { desc = difforig_desc }
)

-- User keymaps {{{1
--------------------------------------------------
map("n", "<Leader>fd", "<cmd>DiffOrig<CR>", { desc = difforig_desc })
keydel("n", "<S-h>")
keydel("n", "<S-l>")
map("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keydel("n", "<A-j>")
keydel("n", "<A-k>")
map("n", "<A-/>", "/\\v", { desc = "Very magic search" })

-- Spell checking
which_key.register({
  c = {
    name = "code/spellcheck",
    s = {
      name = "check spelling",
      e = { "<CMD>setl spell spelllang=en spl?<CR>", "en (all regions)" },
      b = { "<CMD>setl spell spelllang=en_gb spl?<CR>", "en_gb (British)" },
      a = { "<CMD>setl spell spelllang=en spl?<CR>", "en_us (US)" },
      d = { "<CMD>setl spell spelllang=de_de spl?<CR>", "de_de (Germany)" },
      ["<space>"] = { "<CMD>setl nospell spell?<CR>", "Turn off spelling check" },
    },
  },
}, { prefix = "<Leader>", mode = "n" })

-- Vim modelines {{{1
--------------------------------------------------
-- vim: set fdm=marker fdl=0:
