return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = true,
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-dap.nvim",
        keys = {
          { "<leader>tdc", "<cmd> Telescope dap commands<CR>", "Commands" },
          { "<leader>tdf", "<cmd> Telescope dap frames<CR>", "Frames" },
          { "<leader>tdl", "<cmd> Telescope dap list_breakpoints<CR>", "Breakpoints" },
          { "<leader>tds", "<cmd> Telescope dap configurations<CR>", "Configurations" },
          { "<leader>tdv", "<cmd> Telescope dap variables<CR>", "Variables" },
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<leader>tu", "<cmd> Telescope undo<CR>", "Visualize undo tree" },
        },
      },
    },
    keys = {
      { "<leader>tr", "<cmd> Telescope oldfiles<CR>", "Recent files" },
    },
    opts = {
      defaults = {
        find_files = {
          hidden = true,
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
      extensions = {
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width = 0.9,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("undo")
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = function()
      local icons = require("lazyvim.config").icons
      require("symbols-outline").setup({
        symbols = {
          File = { icon = icons.kinds.File, hl = "TSURI" },
          Module = { icon = icons.kinds.Module, hl = "TSNamespace" },
          Namespace = { icon = icons.kinds.Namespace, hl = "TSNamespace" },
          Package = { icon = icons.kinds.Package, hl = "TSNamespace" },
          Class = { icon = icons.kinds.Class, hl = "TSType" },
          Method = { icon = icons.kinds.Method, hl = "TSMethod" },
          Property = { icon = icons.kinds.Property, hl = "TSMethod" },
          Field = { icon = icons.kinds.Field, hl = "TSField" },
          Constructor = { icon = icons.kinds.Constructor, hl = "TSConstructor" },
          Enum = { icon = icons.kinds.Enum, hl = "TSType" },
          Interface = { icon = icons.kinds.Interface, hl = "TSType" },
          Function = { icon = icons.kinds.Function, hl = "TSFunction" },
          Variable = { icon = icons.kinds.Variable, hl = "TSConstant" },
          Constant = { icon = icons.kinds.Constant, hl = "TSConstant" },
          String = { icon = icons.kinds.String, hl = "TSString" },
          Number = { icon = icons.kinds.Number, hl = "TSNumber" },
          Boolean = { icon = icons.kinds.Boolean, hl = "TSBoolean" },
          Array = { icon = icons.kinds.Array, hl = "TSConstant" },
          Object = { icon = icons.kinds.Object, hl = "TSType" },
          Key = { icon = icons.kinds.Key, hl = "TSType" },
          Null = { icon = icons.kinds.Null, hl = "TSType" },
          EnumMember = { icon = icons.kinds.EnumMember, hl = "TSField" },
          Struct = { icon = icons.kinds.Struct, hl = "TSType" },
          Event = { icon = icons.kinds.Event, hl = "TSType" },
          Operator = { icon = icons.kinds.Operator, hl = "TSOperator" },
          TypeParameter = { icon = icons.kinds.TypeParameter, hl = "TSParameter" },
        },
      })
    end,
  },
}
