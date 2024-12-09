return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
        cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
      },
    },
    keys = {
      { "<leader>z", "<cmd> ZenMode<cr>", desc = "Zen mode" },
    },
    opts = {
      plugins = {
        wezterm = { enabled = true },
      },
      on_open = function()
        require("incline").disable()
      end,
      on_close = function()
        require("incline").enable()
      end,
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Used by the `header` section
          header = [[
 ██████╗  █████╗  ██████╗ ██╗     ██╗ █████╗  ██████╗██╗██╗
 ██╔══██╗██╔══██╗██╔════╝ ██║     ██║██╔══██╗██╔════╝██║██║
 ██████╔╝███████║██║  ███╗██║     ██║███████║██║     ██║██║
 ██╔═══╝ ██╔══██║██║   ██║██║     ██║██╔══██║██║     ██║██║
 ██║     ██║  ██║╚██████╔╝███████╗██║██║  ██║╚██████╗██║██║
 ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝╚═╝
  [ github.com/Pagliacii ] ]],
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "󰥩 ", key = "b", desc = "Browse File", action = ":Yazi cwd" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
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
      scrollbar.setup({
        handle = {
          gitsigns = true,
          search = true,
        },
        excluded_filetypes = {
          "alpha",
          "cmp_docs",
          "cmp_menu",
          "dashboard",
          "neo-tree",
          "lazy",
          "mason",
          "noice",
          "prompt",
          "TelescopePrompt",
          "notify",
          "snacks_dashboard",
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
        "<C-f>",
        "<C-b>",
        "<C-u>",
        "<C-d>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      easing = "quadratic",
    },
    keys = {
      "<C-f>",
      "<C-b>",
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
      opts.options.theme = "auto"
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
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
      opts.presets.bottom_search = false
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "b0o/incline.nvim",
    config = function()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        hide = {
          cursorline = true,
        },
        ignore = {
          filetypes = { "DiffviewFiles" },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = " ", changed = " ", added = " " }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "| " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = " ", warn = " ", info = " ", hint = " " }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "| " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            -- { "|  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = {
      relculright = true,
      ft_ignore = { "dashboard", "DiffviewFiles", "snacks_dashboard" },
    },
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    cmds = {
      "MarksToggleSigns",
      "MarksListBuf",
      "MarksListGlobal",
      "MarksListAll",
      "BookmarksList",
      "BookmarksListAll",
      "MarksQFListBuf",
      "MarksQFListGlobal",
      "MarksQFListAll",
      "BookmarksQFList",
      "BookmarksQFListAll",
    },
    opts = {},
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    event = "BufReadPre",
  },
}
