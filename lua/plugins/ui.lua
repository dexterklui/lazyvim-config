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
    opts = {
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

  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "css",
      "html",
      "javascript",
    },
    ft = "css",
    keys = {
      { "<leader>uk", "<cmd>ColorizerToggle<cr>", desc = "Colorizer toggle" },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    -- Very useful to jump to popup message / error box to prevent them from fading away
    -- Also useful integration with neo-tree to choose which window to open file
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function(_, opts)
      require("window-picker").setup(opts)
      local get_win_id = require("window-picker").pick_window
      local pick_window = function()
        vim.fn.win_gotoid(get_win_id())
      end
      vim.keymap.set("n", "<leader>wp", pick_window, { desc = "Pick window" })
    end,
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        bo = {
          filetype = {},
          buftype = {},
        },
      },
    },
    keys = {
      {
        "<leader>wp",
      },
    },
  },
}
-- vi: fdm=indent fdl=1
