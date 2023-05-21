return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "compact",
    },
  },

  {
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>z", "<cmd> ZenMode<cr>", desc = "toggle zen mode" },
    },
    opts = {
      plugins = {
        wezterm = { enabled = true },
      },
    },
  },

  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
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
    end,
  },

  {
    "akinsho/bufferline.nvim",
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

  -- scrollbar for Neovim
  -- {
  --   "dstein64/nvim-scrollview",
  --   event = "BufReadPre",
  --   config = {
  --     excluded_filetypes = { "alpha", "neo-tree" },
  --     current_only = true,
  --     winblend = 75,
  --   },
  -- },
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    event = "BufReadPre",
    opts = {
      hide_if_all_visible = true,
      excluded_filetypes = {
        "alpha",
        "neo-tree",
        "lazy",
        "mason",
        "noice",
      },
      handlers = {
        gitsigns = true,
        search = true,
      },
    },
  },

  {
    "karb94/neoscroll.nvim",
    config = true,
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
    "HiPhish/nvim-ts-rainbow2",
    event = "BufReadPre",
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          -- list of languages you want to disable the plugin for
          disable = {},
          -- Which query to use for finding delimiters
          query = "rainbow-parens",
          -- Highlight the entire buffer all at once
          strategy = require("ts-rainbow").strategy.global,
        },
      })
    end,
  },
}
