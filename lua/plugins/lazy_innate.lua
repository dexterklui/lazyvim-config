return {
  { -- <CR> don't commit 1st item when not selected. No preselect menu item.
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- i_<CR> don't pick first menu item when it's not selected
      if opts.mapping == nil then
        opts.mapping = {}
      end
      opts.mapping["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      })
      -- No preselect menu item
      opts.preselect = cmp.PreselectMode.None
      opts.completion = { completeopt = "menu,menuone,noselect" }
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
  { -- Leaving snippet region makes <Tab> no longer jump back in
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      require("luasnip").setup(opts)
      vim.cmd([[
        imap <silent><expr> <A-e> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<A-e>'
        imap <silent><expr> <A-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
        smap <silent><expr> <A-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      ]])
    end,
    opts = function(_, opts)
      opts.region_check_events = "InsertEnter" -- Check region leave on entering insert mode
    end,
  },
  { -- Add keymaps to toggle mini.pairs for current buffer
    "echasnovski/mini.pairs",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
      vim.keymap.set("n", "<A-p>", function()
        vim.b.minipairs_disable = not vim.b.minipairs_disable
        print("minipair:", not vim.b.minipairs_disable and "enabled" or "disabled")
      end, { desc = "Toggle minipairs in local buffer" })
      vim.keymap.set("i", "<A-p>", function()
        vim.b.minipairs_disable = not vim.b.minipairs_disable
        print("minipair:", not vim.b.minipairs_disable and "enabled" or "disabled")
      end, { desc = "Toggle minipairs in local buffer" })
    end,
  },
}

-- vim: fdm=indent fdl=1
