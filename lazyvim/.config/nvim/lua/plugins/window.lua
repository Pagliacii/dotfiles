return {
  {
    "sindrets/winshift.nvim",
    keys = {
      { "<leader>wm", "<cmd>WinShift<cr>", desc = "Start Win-Move mode" },
      { "<leader>wh", "<cmd>WinShift left<cr>", desc = "Move current window to left" },
      { "<leader>wl", "<cmd>WinShift right<cr>", desc = "Move current window to right" },
      { "<leader>wk", "<cmd>WinShift up<cr>", desc = "Move current window to top" },
      { "<leader>wj", "<cmd>WinShift down<cr>", desc = "Move current window to bottom" },
      { "<leader>wx", "<cmd>WinShift swap<cr>", desc = "Swap windows" },
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        include_current_win = true,
        bo = {
          filetype = { "NvimTree", "neo-tree", "notify", "Outline", "noice", "edgy" },
          buftype = { "terminal" },
        },
      },
      highlights = {
        statusline = {
          focused = {
            fg = "#232634",
            bg = "#a6d189",
          },
          unfocused = {
            fg = "#232634",
            bg = "#99d1db",
          },
        },
        winbar = {
          focused = {
            fg = "#232634",
            bg = "#a6d189",
          },
          unfocused = {
            fg = "#232634",
            bg = "#99d1db",
          },
        },
      },
      picker_config = {
        statusline_winbar_picker = {
          use_winbar = "smart",
        },
      },
    },
    keys = function(_, keys)
      local function window_picker()
        local picker = require("window-picker")
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end
      table.insert(keys, { "<leader>wp", window_picker, desc = "Pick a window" })
      return keys
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      ignored_filetypes = { "neo-tree" },
      resize_mode = {
        silent = true,
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
          end,
        },
      },
    },
    keys = {
      {
        "<leader>wr",
        function(...)
          require("smart-splits").start_resize_mode(...)
        end,
        desc = "Enter resize mode",
      },
      {
        "<C-h>",
        function(...)
          require("smart-splits").move_cursor_left(...)
        end,
        desc = "Move cursor to left",
        noremap = true,
      },
      {
        "<C-l>",
        function(...)
          require("smart-splits").move_cursor_right(...)
        end,
        desc = "Move cursor to right",
        noremap = true,
      },
      {
        "<C-j>",
        function(...)
          require("smart-splits").move_cursor_down(...)
        end,
        desc = "Move cursor to down",
        noremap = true,
      },
      {
        "<C-k>",
        function(...)
          require("smart-splits").move_cursor_up(...)
        end,
        desc = "Move cursor to up",
        noremap = true,
      },
    },
  },
}
