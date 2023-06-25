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

  -- Web development (HTML, CSS, Javascript)
  {
    "rstacruz/sparkup",
    ft = "html",
  },
  {
    "Jezda1337/nvim-html-css", --- Like HTML-CSS Support plugin for VSCode
    enabled = true,
    init = function()
      require("html-css"):setup()
    end,
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, {
            name = "html-css",
            option = {
              max_count = {}, -- not ready yet
              file_types = {
                "html", -- default
              },
              style_sheets = {
                "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
                -- "./style.css",
                -- "index.css",
              },
            },
          })
        end,
      },
    },
  },
}
-- vi: fdm=indent fdl=1
