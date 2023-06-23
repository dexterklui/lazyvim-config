return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      if require("lazyvim.util").has("noice.nvim") and require("lazyvim.util").has("nvim-notify") then
        opts.defaults["<leader>sn"] = { name = "+noice/notify" }
      end
    end,
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "rcarriga/nvim-notify",
        config = function(_)
          require("telescope").load_extension("notify")
        end,
        keys = {
          { "<leader>snm", "<Cmd>Telescope notify<CR>", desc = "Search/show messages history" },
        },
      },
    },
  },
  {
    "aserowy/tmux.nvim",
    config = function(_)
      return require("tmux").setup()
    end,
    opt = {
      copy_sync = {
        sync_clipboard = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
    keys = {
      { "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", desc = "Go to right window" },
      { "<c-left>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "Resize window to left" },
      { "<c-down>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "Resize window to down" },
      { "<c-up>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "Resize window to up" },
      { "<c-right>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "Resize window to right" },
    },
  },
}
