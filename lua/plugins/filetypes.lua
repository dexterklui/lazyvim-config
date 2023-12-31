return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    opts = {},
    config = function()
      local aug = vim.api.nvim_create_augroup("dqMarkdownPreview", {})
      vim.api.nvim_create_autocmd("FileType", {
        group = aug,
        pattern = "markdown",
        callback = function(_)
          vim.keymap.set("n", "<Leader>cp", "<Cmd>MarkdownPreviewToggle<CR>", {
            buffer = true,
            desc = "Toggle Markdown Preview",
          })
          vim.b.undo_ftplugin = vim.b.undo_ftplugin .. "| nunmap <buffer> <Leader>cp"
        end,
        desc = "Add keymap to toggle Markdown Preview",
      })
    end,
  },

  -- Web development (HTML, CSS, Javascript)
  {
    "rstacruz/sparkup",
    ft = "html",
  },
  {
    "Jezda1337/nvim-html-css", --- Like HTML-CSS Support plugin for VSCode
    enabled = (vim.env.NVIM_HTML_CSS ~= nil),
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
                "/media/mikeX/Library/bootstrap-5.3.0-dist/css/bootstrap.min.css",
                "/media/mikeX/Library/animate.css",

                "./style.css",
                "./index.css",
                "assets/style/stylesheet.css",
                "assets/style/index.css",
                "assets/style/style.css",
              },
            },
          })
        end,
      },
    },
    commit = "b4ea468395438f864020ac4acb23a79f13ff",
  },
}
-- vi: fdm=indent fdl=1
