return {
  { -- hrsh7th/nvim-cmp -- <CR> don't commit 1st item when not selected. No preselect menu item.
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
  { -- nvim-neo-tree/neo-tree.nvim -- auto close neo-tree on file open
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
  { -- L3MON4D3/LuaSnip -- Leaving snippet region makes <Tab> no longer jump back in
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
  { -- echasnovski/mini.pairs -- Add keymaps to toggle mini.pairs for current buffer
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
  { -- echasnovski/mini.ai -- Save jumplist before goto_left/right
    "echasnovski/mini.ai",
    opts = function(_, opts)
      if opts.mappings == nil then
        opts.mappings = {}
      end
      opts.mappings.goto_left = "<plug>miniAiLeft"
      opts.mappings.goto_right = "<plug>miniAiRight"
    end,
    keys = {
      { "g[", "m'<plug>miniAiLeft", remap = true, desc = 'Move to left "around (save to jumplist)"' },
      { "g]", "m'<plug>miniAiRight", remap = true, desc = 'Move to left "around (save to jumplist)"' },
    },
  },
  { -- nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    config = function(_, opts)
      require("lualine").setup(opts)
      vim.g.lualine_mode_map = {
        n = "N",
        i = "I",
        c = "C",
        cv = "Ex",
        v = "V",
        V = "V.L",
        [""] = "^V",
        s = "S",
        S = "S.L",
        [""] = "^S",
        ix = "i^X",
        ic = "i^N",
        r = "<Enter>",
        rm = "--more--",
        t = "TRM",
      }
      vim.g.VM_set_statusline = 0
      require("which-key").register({
        t = {
          name = "Treesitter (winbar)",
          t = {
            "<cmd>lua require('lualine').hide({place={'winbar'}, unhide=true,})<cr>",
            "Enable treesitter (winbar)",
          },
          T = {
            "<cmd>lua require('lualine').hide({place={'winbar'}, unhide=false,})<cr>",
            "Disable treesitter (winbar)",
          },
        },
      }, { prefix = "<leader>u" })
      vim.cmd([[
	      hi NavicIconsFile guibg=#1E2030
	      hi NavicIconsModule guibg=#1E2030
	      hi NavicIconsNamespace guibg=#1E2030
	      hi NavicIconsPackage guibg=#1E2030
	      hi NavicIconsClass guibg=#1E2030
	      hi NavicIconsMethod guibg=#1E2030
	      hi NavicIconsProperty guibg=#1E2030
	      hi NavicIconsField guibg=#1E2030
	      hi NavicIconsConstructor guibg=#1E2030
	      hi NavicIconsEnum guibg=#1E2030
	      hi NavicIconsInterface guibg=#1E2030
	      hi NavicIconsFunction guibg=#1E2030
	      hi NavicIconsVariable guibg=#1E2030
	      hi NavicIconsConstant guibg=#1E2030
	      hi NavicIconsString guibg=#1E2030
	      hi NavicIconsNumber guibg=#1E2030
	      hi NavicIconsBoolean guibg=#1E2030
	      hi NavicIconsArray guibg=#1E2030
	      hi NavicIconsObject guibg=#1E2030
	      hi NavicIconsKey guibg=#1E2030
	      hi NavicIconsNull guibg=#1E2030
	      hi NavicIconsEnumMember guibg=#1E2030
	      hi NavicIconsStruct guibg=#1E2030
	      hi NavicIconsEvent guibg=#1E2030
	      hi NavicIconsOperator guibg=#1E2030
	      hi NavicIconsTypeParameter guibg=#1E2030
	      hi NavicText guibg=#1E2030
	      hi NavicSeparator guibg=#1E2030
      ]])
    end,
    opts = function(_, opts)
      opts.options.disabled_filetypes.winbar = {
        "dashboard",
        "alpha",
        "help",
        "neo-tree",
        "terminal",
        "aerial",
        "qf",
        "Trouble",
        "gitcommit",
        "dqn",
      }

      opts.sections.lualine_a = {
        function()
          local vminfos = vim.fn["g:VMInfos"]()
          if vminfos and vminfos.status ~= nil then
            local result = "VM " .. string.gsub(vminfos.ratio, " ", "")
            for i = 1, #vminfos.patterns do
              result = result .. " /" .. vminfos.patterns[i]
            end
            return result
          end
          local mode_map = vim.g.lualine_mode_map
          local mode = vim.fn.mode(true)
          return mode_map[mode] == nil and mode or mode_map[mode]
        end,
      }

      local section_c = opts.sections.lualine_c
      section_c[#section_c] = nil -- Remove the section for nvim-navic
      for _, x in ipairs(section_c) do
        if x[1] == "filename" then
          x.symbols = { modified = "📝", readonly = "🚫", unnamed = "📛" }
          break
        end
      end

      local section_y = opts.sections.lualine_y
      for _, y in ipairs(section_y) do
        y.separator = " "
      end
      section_y[#section_y].padding = 0
      table.insert(section_y, {
        function()
          return "F" .. vim.b.fdl
        end,
        separator = "",
        padding = { left = 0, right = 1 },
        cond = function()
          return vim.b.fdl ~= nil
        end,
      })

      opts.sections.lualine_z = {
        { "encoding", separator = " ", padding = { left = 1, right = 0 } },
        { "fileformat", separator = " ", padding = { left = 0, right = 1 } },
      }

      opts.winbar = {
        lualine_c = {
          {
            function()
              return "󱘎 "
            end,
            color = { fg = "#29CFF0", bg = "#1E2030" },
            padding = { left = 1, right = 0 },
          },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
            color = { fg = "#ffffff", bg = "#1E2030" },
            padding = { left = 0, right = 1 },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ut",
      },
      {
        "<leader>utt",
      },
      {
        "<leader>utT",
      },
    },
    dependencies = {
      "SmiteshP/nvim-navic",
    },
  },
  { -- SmiteshP/nvim-navic -- override option (depth limit)
    "SmiteshP/nvim-navic",
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 0,
        icons = require("lazyvim.config").icons.kinds,
      }
    end,
  },
}

-- vim: fdm=indent fdl=1
