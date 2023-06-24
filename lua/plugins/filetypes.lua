return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = "markdown",
  },

  -- HTML
  {
    "rstacruz/sparkup",
    ft = "html",
  },
}
-- vi: fdm=indent fdl=1
