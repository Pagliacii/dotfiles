return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 1500,
      render = "compact",
    },
  },

  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim" },
    },
    keys = {
      { "<leader>z", "<cmd> ZenMode<cr>", desc = "Zen mode" },
    },
    opts = {
      plugins = {
        wezterm = { enabled = true },
      },
    },
  },

  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
██████╗  █████╗  ██████╗ ██╗     ██╗ █████╗  ██████╗██╗██╗
██╔══██╗██╔══██╗██╔════╝ ██║     ██║██╔══██╗██╔════╝██║██║
██████╔╝███████║██║  ███╗██║     ██║███████║██║     ██║██║
██╔═══╝ ██╔══██║██║   ██║██║     ██║██╔══██║██║     ██║██║
██║     ██║  ██║╚██████╔╝███████╗██║██║  ██║╚██████╗██║██║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝╚═╝
                  [ github.com/Pagliacii ]
      ]]
      dashboard.section.header.val = vim.split(logo, "\n", {})

      dashboard.config.opts.setup = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          desc = "disable tabline for alpha",
          callback = function()
            vim.opt.showtabline = 0
          end,
        })
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          desc = "enable tabline after alpha",
          callback = function()
            vim.opt.showtabline = 2
          end,
        })
      end

      local button = dashboard.button("p", " " .. " Projects", ":Telescope project<cr>")
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      dashboard.section.buttons.val[6] = nil
      table.insert(dashboard.section.buttons.val, 4, button)

      return dashboard
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        color_icons = true,
        diagnostics = false,
        highlights = {
          buffer_selected = {
            gui = "none",
          },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "Outline",
            text = "Symbols Outline",
            highlight = "TSType",
            text_align = "left",
          },
        },
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = {
          color = colors.bg_highlight,
          gitsigns = true,
          search = true,
        },
        excluded_filetypes = {
          "alpha",
          "neo-tree",
          "lazy",
          "mason",
          "noice",
          "prompt",
          "TelescopePrompt",
          "notify",
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
        hide_if_all_visible = true,
        show_in_active_only = true,
      })

      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },

  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
    },
    keys = {
      "<C-u>",
      "<C-d>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rd = require("rainbow-delimiters")
      local opts = {}
      opts.strategy = {
        [""] = rd.strategy["global"],
        vim = rd.strategy["local"],
      }
      opts.query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-delimiters",
      }
      opts.highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      }
      require("rainbow-delimiters.setup")(opts)
      return true
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    cmd = { "TransparentToggle" },
    keys = {
      { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "Transparent background", noremap = true },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      if type(opts.filetype_exclude) == "table" then
        vim.list_extend(opts.filetype_exclude, { "noice" })
      end
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c) -- nvim-navic
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c) -- filename
      local ok, git_blame = pcall(require, "gitblame")
      if ok then
        opts.sections.lualine_c[#opts.sections.lualine_c + 1] = {
          git_blame.get_current_blame_text,
          cond = git_blame.is_blame_text_available,
        }
      end
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      local api = require("dropbar.api")
      local confirm = function()
        local menu = api.get_current_dropbar_menu()
        if not menu then
          return
        end
        local cursor = vim.api.nvim_win_get_cursor(menu.win)
        local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
        if component then
          menu:click_on(component, nil, 1, "l")
        end
      end
      local quit = function()
        local menu = api.get_current_dropbar_menu()
        if menu then
          menu:close()
        end
      end
      local menu = opts.menu or { quick_navigation = true }
      local keymaps = menu.keymaps or {}
      menu.keymaps = vim.tbl_extend("force", keymaps, {
        ["i"] = confirm,
        ["<ESC>"] = quit,
        ["q"] = quit,
      })
      opts.menu = menu
      return opts
    end,
    keys = function(_, keys)
      local api = require("dropbar.api")
      vim.list_extend(keys, {
        { "<leader>;", api.pick, desc = "Dropbar pick" },
      })
    end,
  },
}
