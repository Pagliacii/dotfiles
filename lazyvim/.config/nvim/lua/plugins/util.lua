return {
  {
    "wakatime/vim-wakatime",
    event = "InsertEnter",
    enabled = vim.fn.executable("wakatime") == 1,
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
    "monaqa/dial.nvim",
    -- lazy-load on keys
    -- mode is `n` by default. For more advanced options, check the section on key mappings
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
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
    "max397574/better-escape.nvim",
    config = true,
    keys = {
      { "jj", mode = "i" },
      { "jk", mode = "i" },
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
      { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },
    },
  },

  {
    "chrisgrieser/nvim-recorder",
    opts = {
      slots = { "a", "b", "c", "d", "e", "f" },
      lessNotifications = false,
    },
    keys = { "q", "Q", "<C-q>", "cq", "yq" },
  },

  {
    "anuvyklack/fold-preview.nvim",
    dependencies = {
      { "anuvyklack/keymap-amend.nvim" },
    },
    event = "BufReadPost",
    opts = {
      auto = 400,
      border = "rounded",
      default_keybindings = false,
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTRun",
      "ChatGPTEditWithInstructions",
      "ChatGPTCompleteCode",
    },
  },

  {
    "Sanix-Darker/snips.nvim",
    cmd = {
      "SnipsCreate",
      "SnipsCreateFromRegister",
      "SnipsList",
    },
    opts = {
      post_behavior = "echo_and_yank",
      ssh_cmd = "ssh -T",
    },
    keys = {
      { "<leader>C", ":SnipsCreate<cr>", mode = { "v" }, desc = "Share selected code", silent = true },
    },
  },

  {
    "Pagliacii/sys-open.nvim",
    config = true,
    cmd = { "SysOpen" },
    keys = {
      { "gx", "<cmd>SysOpen<cr>" },
    },
  },

  {
    "LudoPinelli/comment-box.nvim",
    cmd = {
      "CBllbox",
      "CBlcbox",
      "CBlrbox",
      "CBclbox",
      "CBccbox",
      "CBcrbox",
      "CBrlbox",
      "CBrcbox",
      "CBrrbox",
      "CBalbox",
      "CBacbox",
      "CBarbox",
      "CBline",
      "CBcline",
      "CBrline",
    },
  },

  {
    "jokajak/keyseer.nvim",
    version = false,
    config = true,
    cmd = { "KeySeer" },
  },

  {
    "smjonas/live-command.nvim",
    event = "BufReadPost",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
          Reg = {
            cmd = "norm",
            -- This will transform ":5Reg a" into ":norm 5@a"
            args = function(opts)
              return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
            end,
          },
        },
      })
    end,
  },

  {
    "stefanlogue/hydrate.nvim",
    lazy = false,
    opts = {
      -- The interval between notifications in minutes
      minute_interval = 15,
      -- The render style for notifications
      -- Accepted values are "default", "minimal", "simple" or "compact"
      render_style = "compact",
      -- Loads time of last drink on startup
      -- Useful if you don't have long-running neovim instances
      -- or if you tend to have multiple instances running at a time
      persist_timer = true,
    },
    cmd = {
      "HydrateWhen",
      "HydrateNow",
      "DrinkInterval",
      "HydrateDisable",
      "HydrateEnable",
    },
    keys = {
      { "<leader>h", "<cmd>HydrateNow<cr>", desc = "Drink water", noremap = true, silent = true },
    },
  },
}
