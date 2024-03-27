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
    "nvimdev/dashboard-nvim",
    opts = function()
      local logo = [[
 ██████╗  █████╗  ██████╗ ██╗     ██╗ █████╗  ██████╗██╗██╗
 ██╔══██╗██╔══██╗██╔════╝ ██║     ██║██╔══██╗██╔════╝██║██║
 ██████╔╝███████║██║  ███╗██║     ██║███████║██║     ██║██║
 ██╔═══╝ ██╔══██║██║   ██║██║     ██║██╔══██║██║     ██║██║
 ██║     ██║  ██║╚██████╔╝███████╗██║██║  ██║╚██████╗██║██║
 ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝╚═╝
  [ github.com/Pagliacii ]
      ]]
      logo = string.rep("\n", 5) .. logo .. "\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope file_browser", desc = " Browse files", icon = "󰥩 ", key = "b" },
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            { action = "Telescope project", desc = " Projects", icon = " ", key = "p" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "e" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
    keys = {
      {
        "<leader>o",
        "<cmd>Dashboard<cr>",
        desc = "Open Dashboard",
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
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
          "dashboard",
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
      require("rainbow-delimiters.setup").setup(opts)
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
    opts = {
      exclude = {
        filetypes = {
          "aerial",
          "noice",
        },
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "dropbar_menu",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "aerial",
          "noice",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local git = vim.fs.find(".git", {
        upward = true,
        stop = vim.uv.os_homedir(),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        type = "directory",
      })
      if #git > 0 then
        local ok, git_blame = pcall(require, "gitblame")
        if ok then
          table.insert(opts.sections.lualine_c, {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available,
          })
        end
      end
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      local utils = require("dropbar.utils")
      local quit = function()
        local menu = utils.menu.get_current()
        if menu then
          menu:close()
        end
      end
      local menu = opts.menu or { quick_navigation = true }
      local keymaps = menu.keymaps or {}
      menu.keymaps = vim.tbl_extend("force", keymaps, {
        ["<ESC>"] = quit,
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

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
    end,
  },
}
