return {
  {
    "wakatime/vim-wakatime",
    event = "InsertEnter",
  },

  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        -- Require providers
        require("hover.providers.dap")
        require("hover.providers.diagnostic")
        require("hover.providers.dictionary")
        require("hover.providers.fold_preview")
        require("hover.providers.gh")
        require("hover.providers.gh_user")
        require("hover.providers.highlight")
        require("hover.providers.lsp")
        require("hover.providers.man")
      end,
    },
    keys = {
      {
        "<leader>hh",
        function(...)
          require("hover").hover(...)
        end,
        desc = "hover",
      },
      {
        "<leader>hs",
        function(...)
          require("hover").hover_select(...)
        end,
        desc = "select",
      },
      {
        "<leader>hp",
        function(...)
          require("hover").hover_switch("previous", ...)
        end,
        desc = "previous source",
      },
      {
        "<leader>hn",
        function(...)
          require("hover").hover_switch("next", ...)
        end,
        desc = "next source",
      },
    },
  },

  {
    "voldikss/vim-translator",
    keys = {
      { "<leader>vw", "<cmd>TranslateW<cr>", mode = { "n", "v" }, desc = "Display translation in window" },
    },
  },

  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
    },
    cmd = { "Cheatsheet", "CheatsheetEdit" },
    keys = {
      { "<localleader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },
    },
  },

  {
    "chrisgrieser/nvim-recorder",
    event = "BufReadPost",
    config = function()
      local recorder = require("recorder")
      recorder.setup({
        -- Named registers where macros are saved (single lowercase letters only).
        -- The first register is the default register used as macro-slot after
        -- startup.
        slots = { "a", "b", "c", "d", "e", "f" },
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
          editMacro = "cq",
          deleteAllMacros = "dq",
          yankMacro = "yq",
          -- ⚠️ this should be a string you don't use in insert mode during a macro
          addBreakPoint = "##",
        },
        -- If enabled, only essential notifications are sent.
        -- If you do not use a plugin like nvim-notify, set this to `true`
        -- to remove otherwise annoying messages.
        lessNotifications = true,
        clear = true,
      })

      local lualine = require("lualine")
      local lualineX = lualine.get_config().sections.lualine_x or {}
      table.insert(lualineX, { recorder.displaySlots, color = { fg = "orange" } })
      lualine.setup({
        sections = {
          lualine_x = lualineX,
        },
      })
    end,
  },

  {
    "Pagliacii/sys-open.nvim",
    cmd = { "SysOpen" },
    opts = {},
    keys = {
      { "gx", "<cmd>SysOpen<cr>", desc = "Open URL under cursor" },
    },
  },

  {
    "smjonas/live-command.nvim",
    event = "BufReadPost",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
      plugins = {
        non_standalone = true,
      },
    },
  },

  {
    "cenk1cenk2/jq.nvim",
    enabled = vim.fn.executable("jq") == 1,
    dependencies = {
      -- https://github.com/nvim-lua/plenary.nvim
      "nvim-lua/plenary.nvim",
      -- https://github.com/MunifTanjim/nui.nvim
      "MunifTanjim/nui.nvim",
      -- https://github.com/grapp-dev/nui-components.nvim
      "grapp-dev/nui-components.nvim",
    },
    ft = "json",
    keys = {
      {
        "<leader>vj",
        function(...)
          require("jq").run(...)
        end,
        desc = "Run jq",
      },
    },
  },

  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommanded, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    config = function()
      local pomo = require("pomo")
      pomo.setup({})

      require("telescope").load_extension("pomodori")

      local lualine = require("lualine")
      local lualineX = lualine.get_config().sections.lualine_x or {}
      table.insert(lualineX, 1, {
        function()
          local timer = pomo.get_first_to_finish()
          if timer == nil then
            return ""
          end
          return "󰄉 " .. tostring(timer)
        end,
        color = { fg = "orange" },
      })
    end,
    keys = {
      {
        "<leader>T",
        function()
          require("telescope").extensions.pomodori.timers()
        end,
        desc = "Pomodori Timers",
      },
    },
  },
}
