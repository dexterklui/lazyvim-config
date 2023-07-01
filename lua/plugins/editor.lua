return {
  {
    "stevearc/aerial.nvim", --tagbar like window
    config = function(_)
      require("aerial").setup() -- Don't know why this line is required
      require("telescope").load_extension("aerial")
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "telescope.nvim",
    },
    keys = {
      { "<leader>;", "<cmd>AerialToggle!<CR>", desc = "Tagbar (Aerial)" },
      { "<leader>sA", "<cmd>Telescope aerial<CR>", desc = "Aerial (tagbar-like)" },
    },
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "natecraddock/workspaces.nvim",
    config = function(_, opts)
      require("workspaces").setup(opts)
      require("telescope").load_extension("workspaces")
      local which_key = require("which-key")
      which_key.register({
        p = {
          name = "Projects/Workspaces",
          l = { "<cmd>WorkspacesList<cr>", "List Workspaces" },
          a = { "<cmd>WorkspacesAdd<cr>", "Add current workspace" },
          r = { "<cmd>WorkspacesRemove<cr>", "Remove current workspace" },
        },
      }, { prefix = "<leader>" })
    end,
    opts = {
      cd_type = "local",
      hooks = {
        open = { "Telescope find_files" },
      },
    },
    dependencies = {
      "telescope.nvim",
    },
    keys = {
      { "<leader>sp", "<cmd>Telescope workspaces<cr>", desc = "Places (Workspaces)" },
      { "<leader>pl" },
      { "<leader>pa" },
      { "<leader>pr" },
    },
    event = "VeryLazy",
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_leader = "<leader>m"
      local which_key = require("which-key")
      which_key.register({
        m = {
          name = "Multi-visual",
        },
      }, { prefix = "<leader>" })
      which_key.register({
        m = {
          name = "Multi-visual",
        },
      }, { prefix = "<leader>", mode = "v" })

      local VM_maps = {
        ["Add Cursor Down"] = "<m-j>",
        ["Add Cursor Up"] = "<m-k>",
      }
      vim.g.VM_maps = VM_maps
    end,
  },
  keys = {
    { "<leader>m" },
  },
}

-- vi: fdm=indent fdl=1
