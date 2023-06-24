return {
  {
    "stevearc/aerial.nvim", --tagbar like window
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        "telescope.nvim",
        config = function(_)
          require("telescope").load_extension("aerial")
        end,
        keys = {
          { "<leader>sA", "<cmd>Telescope aerial<CR>", desc = "Aerial (tagbar-like)" },
        },
        opts = {},
      },
    },
    keys = {
      { "<leader>;", "<cmd>AerialToggle!<CR>", desc = "Tagbar (Aerial)" },
    },
  },
  {
    "tpope/vim-fugitive",
  },
}

-- vi: fdm=indent fdl=1
