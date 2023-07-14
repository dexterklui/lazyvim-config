return {
  { -- folke/which-key.nvim
    "folke/which-key.nvim",
    opts = function(_, opts)
      if require("lazyvim.util").has("noice.nvim") and require("lazyvim.util").has("nvim-notify") then
        opts.defaults["<leader>sn"] = { name = "+noice/notify" }
      end
    end,
  },
  { -- telescope.nvim
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
  { -- aserowy/tmux.nvim
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        sync_clipboard = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
    keys = {
      { "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", desc = "Go to right window" },
      { "<c-left>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "Resize window to left" },
      { "<c-down>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "Resize window to down" },
      { "<c-up>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "Resize window to up" },
      { "<c-right>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "Resize window to right" },
    },
  },
  { -- norcalli/nvim-colorizer.lua
    "norcalli/nvim-colorizer.lua",
    opts = {
      "css",
      "html",
      "javascript",
    },
    ft = "css",
    keys = {
      { "<leader>uk", "<cmd>ColorizerToggle<cr>", desc = "Colorizer toggle" },
    },
  },
  { -- s1n7ax/nvim-window-picker
    "s1n7ax/nvim-window-picker",
    -- Very useful to jump to popup message / error box to prevent them from fading away
    -- Also useful integration with neo-tree to choose which window to open file
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function(_, opts)
      require("window-picker").setup(opts)
      local get_win_id = require("window-picker").pick_window
      local pick_window = function()
        vim.fn.win_gotoid(get_win_id())
      end
      vim.keymap.set("n", "<leader>wp", pick_window, { desc = "Pick window" })
    end,
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        bo = {
          filetype = {},
          buftype = {},
        },
      },
    },
    keys = {
      {
        "<leader>wp",
      },
    },
  },
  { -- modern fold column -- kevinhwang91/nvim-ufo
    "kevinhwang91/nvim-ufo",
    enabled = true,
    event = "BufRead",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
    end,
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󱦶 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
    config = function(_, opts)
      -- Keymaps
      local map = vim.keymap.set
      map("n", "z<space>", function()
        if vim.b.fdl == nil then
          vim.b.fdl = vim.wo.fdl
        end
        vim.wo.fdl = 99
        require("ufo").closeFoldsWith(vim.b.fdl)
        print("actual_fdl: " .. vim.b.fdl)
      end, { desc = "open all folds (ufo)" })
      map("n", "zR", function()
        vim.wo.fdl = 99
        vim.b.fdl = 10
        require("ufo").openAllFolds()
      end, { desc = "open all folds (ufo)" })
      map("n", "zM", function()
        vim.wo.fdl = 99
        vim.b.fdl = 0
        require("ufo").closeAllFolds()
      end, { desc = "close all folds (ufo)" })
      map("n", "zr", function()
        if vim.b.fdl == nil then
          vim.b.fdl = vim.wo.fdl
        end
        vim.wo.fdl = 99
        vim.b.fdl = vim.b.fdl + 1
        require("ufo").closeFoldsWith(vim.b.fdl)
      end, { desc = "open 1 level fold" }) -- closeAllFolds == closeFoldsWith(0)
      map("n", "zm", function()
        if vim.b.fdl == nil then
          vim.b.fdl = vim.wo.fdl
        end
        vim.wo.fdl = 99
        if vim.b.fdl > 0 then
          vim.b.fdl = vim.b.fdl - 1
        end
        require("ufo").closeFoldsWith(vim.b.fdl)
      end, { desc = "close 1 level fold" }) -- closeAllFolds == closeFoldsWith(0)
      map("n", "zx", function()
        if vim.b.fdl == nil then
          vim.b.fdl = vim.wo.fdl
        end
        vim.wo.fdl = 99
        require("ufo").closeFoldsWith(vim.b.fdl)
        vim.cmd.normal("16zo") -- XXX: Just open 16 times
      end, { desc = "Apply foldlevel then open at cursor" }) -- closeAllFolds == closeFoldsWith(0)
      map("n", "zX", function()
        if vim.b.fdl == nil then
          vim.b.fdl = vim.wo.fdl
        end
        vim.wo.fdl = 99
        require("ufo").closeFoldsWith(vim.b.fdl)
      end, { desc = "Apply foldlevel then open at cursor" }) -- closeAllFolds == closeFoldsWith(0)
      map("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "peek fold / hover" })
      map("n", "<leader>z", ":Foldufo ", { desc = "Set fold level" })

      -- Commands
      vim.api.nvim_create_user_command("Foldufo", function(cmd_opts)
        local fdl = cmd_opts.args and tonumber(cmd_opts.args) or 0
        vim.wo.fdl = 99
        vim.b.fdl = fdl
        print("actual_fdl: " .. fdl)
        require("ufo").closeFoldsWith(fdl)
      end, {
        nargs = "?",
      })

      -- Fold options
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      local dqAugUfo = vim.api.nvim_create_augroup("dqAugUfo", { clear = true })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          vim.b.fdl = 0
          if vim.wo.fdl ~= 99 then
            vim.b.fdl = vim.wo.fdl
            vim.wo.fdl = 99
          end
          vim.wo.fdc = "1"
        end,
        group = dqAugUfo,
        pattern = {
          "*.html",
          "*.md",
          "*.lua",
          "*.js",
          "*.dqn",
          "*.c",
          "*.h",
          "*.cpp",
        },
      })

      require("ufo").setup(opts)
    end,
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            -- foldfunc = "builtin",
            -- setopt = true,
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
  },
  { -- tiagovla/scope.nvim -- scope buffers to their tab
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    opts = {},
  },
}

-- vim: fdm=indent fdl=1
