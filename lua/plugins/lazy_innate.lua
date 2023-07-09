return {
  { -- Unmap i_<CR>
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<m-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
    end,
  },
  { -- auto close neo-tree on file open
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      if opts["event_hadnlers"] == nil then
        opts["event_handlers"] = {}
      end
      table.insert(opts.event_handlers, {
        event = "file_opened",
        handler = function()
          -- auto close
          require("neo-tree").close_all()
        end,
      })
    end,
  },
}
