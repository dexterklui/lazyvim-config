return {
  { -- pwntester/octo.nvim
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
    cmd = "Octo",
  },
}
-- vi: fdm=indent fdl=1
