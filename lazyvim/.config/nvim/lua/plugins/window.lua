return {
  {
    "sindrets/winshift.nvim",
    keys = {
      { "<leader>wM", "<cmd>WinShift<cr>", desc = "Start Win-Move mode" },
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
      {
        "<A-h>",
        function(...)
          require("smart-splits").resize_left(...)
        end,
        desc = "Resize left",
        noremap = true,
      },
      {
        "<A-j>",
        function(...)
          require("smart-splits").resize_down(...)
        end,
        desc = "Resize down",
        noremap = true,
      },
      {
        "<A-k>",
        function(...)
          require("smart-splits").resize_up(...)
        end,
        desc = "Resize up",
        noremap = true,
      },
      {
        "<A-l>",
        function(...)
          require("smart-splits").resize_right(...)
        end,
        desc = "Resize right",
        noremap = true,
      },
    },
  },

  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      tint = -45,
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        if floating then
          return true
        end
        local excluded_buftypes = { "nofile", "terminal" }
        if vim.tbl_contains(excluded_buftypes, buftype) then
          return true
        end
        local excluded_filetypes = { "alpha", "dashboard", "dap-repl", "neo-tree", "toggleterm" }
        if vim.tbl_contains(excluded_filetypes, filetype) then
          return true
        end
        local excluded_ft_prefixes = { "dapui_" }
        for _, prefix in ipairs(excluded_ft_prefixes) do
          if filetype:sub(1, #prefix) == prefix then
            return true
          end
        end
        return false
      end,
    },
  },

  {
    "stevearc/stickybuf.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave" },
    opts = {
      no_exec_files = {
        "packer",
        "TelescopePrompt",
        "mason",
        "CompetiTest",
        "NvimTree",
        "neo-tree",
        "lazy",
        "edgy",
      },
      only_line_seq = false,
      hi = {
        fg = "#d8a657",
      },
    },
  },
}
