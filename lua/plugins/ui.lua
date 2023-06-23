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
}
