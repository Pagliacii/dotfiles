return {
  {
    "wakatime/vim-wakatime",
    event = "InsertEnter",
  },

  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        require("hover.providers.dictionary")
      end,
    },
    keys = {
      {
        "<leader>Ud",
        function(...)
          require("hover").hover(...)
        end,
        desc = "Lookup word under cursor in dictionary",
      },
    },
  },

  {
    "voldikss/vim-translator",
    keys = {
      { "<leader>Uw", "<cmd>TranslateW<cr>", mode = { "n", "v" }, desc = "Display translation in window" },
    },
  },

  {
    "ziontee113/icon-picker.nvim",
    dependencies = {
      {
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        keys = function(_, keys)
          local toggle = function()
            local enabled = false
            return function()
              vim.cmd([[ColorizerToggle]])
              enabled = not enabled
              if enabled then
                vim.notify("Colorizer enabled")
              else
                vim.notify("Colorizer disabled")
              end
            end
          end
          table.insert(keys, { "<leader>u;", toggle(), desc = "Toggle colorizer" })
          return keys
        end,
        opts = {
          filetyps = { "*" },
          user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            AARRGGBB = true, -- 0xAARRGGBB hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "virtualtext",
            -- True is same as normal
            tailwind = false, -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
            virtualtext = "■",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = true,
          },
        },
      },
    },
    opts = {
      disable_legacy_commands = true,
    },
    keys = {
      {
        "<leader>Pin",
        "<cmd>IconPickerNormal nerd_font<cr>",
        desc = "Pick nerd_font",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Pie",
        "<cmd>IconPickerNormal emoji<cr>",
        desc = "Pick emoji",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Pih",
        "<cmd>IconPickerNormal html_colors<cr>",
        desc = "Pick html_colors",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Pis",
        "<cmd>IconPickerNormal symbols<cr>",
        desc = "Pick symbols",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Piy",
        "<cmd>IconPickerYank nerd_font emoji symbols html_colors<cr>",
        desc = "Yank icon",
        noremap = true,
        silent = true,
      },
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
    "stefanlogue/hydrate.nvim",
    event = "VeryLazy",
    opts = {
      -- The interval between notifications in minutes
      minute_interval = 15,
      -- The render style for notifications
      -- Accepted values are "default", "minimal", "simple" or "compact"
      render_style = "minimal",
      -- Loads time of last drink on startup
      -- Useful if you don't have long-running neovim instances
      -- or if you tend to have multiple instances running at a time
      persist_timer = false,
    },
    cmd = {
      "HydrateWhen",
      "HydrateNow",
      "DrinkInterval",
      "HydrateDisable",
      "HydrateEnable",
    },
    keys = {
      {
        "<leader>h",
        "<cmd>HydrateNow<cr>",
        desc = "Drink water",
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "uga-rosa/ccc.nvim",
    config = true,
    cmd = { "CccPick", "CccConvert", "CccHighligherToggle" },
    keys = {
      { "<leader>UCp", "<cmd>CccPick<cr>", desc = "Color picker", noremap = true, silent = true },
      { "<leader>UCc", "<cmd>CccConvert<cr>", desc = "Color convert", noremap = true, silent = true },
      { "<leader>UCt", "<cmd>CccHighligherToggle<cr>", desc = "Color highlight", noremap = true, silent = true },
    },
  },

  {
    "sarrisv/readermode.nvim",
    cmd = "ReaderMode",
    opts = {
      enabled = false, -- Turned off by default
      keymap = "<leader>Ur",
    },
    keys = {
      { "<leader>Ur", "<cmd>ReaderMode<cr>", desc = "Reader mode", noremap = true, silent = true },
    },
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
    "aliqyan-21/wit.nvim",
    cmd = { "WitSearch", "WitSearchVisual", "WitSearchWiki" },
    config = true,
    keys = {
      {
        "<leader>Us",
        ":'<,'>WitSearchVisual<cr>",
        mode = { "v" },
        desc = "Search selected text",
        noremap = true,
        silent = true,
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
        "<leader>Uj",
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
        "<leader>Ut",
        function()
          require("telescope").extensions.pomodori.timers()
        end,
        desc = "Manage Pomodori Timers",
      },
    },
  },

  {
    "atiladefreitas/dooing",
    cmd = { "Dooing" },
    keys = { { "<localleader>d", desc = "Toggle Doing window" } },
    opts = {
      keymaps = {
        toggle_window = "<localleader>d",
      },
    },
  },
}
