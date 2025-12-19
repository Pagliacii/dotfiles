return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "editorconfig-checker",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.trail_space,
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = {
      keymaps = {
        useDefaults = true,
        -- disable only some default keymaps, for example { "ai", "!" }
        -- (only relevant when you set `useDefaults = true`)
        ---@type string[]
        disabledDefaults = { "r" },
      },
    },
  },

  {
    "nvim-mini/mini.operators",
    version = false,
    event = "BufReadPost",
    opts = {
      exchange = {
        prefix = "go",
      },
      replace = {
        prefix = "gq",
      },
    },
  },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufReadPost",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      { "ga.", "<cmd>TextCaseOpenTelescope<cr>", mode = { "n", "x", "v" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup({})
    end,
    keys = {
      { "zR", [[<cmd>lua require("ufo").openAllFolds()<cr>]], desc = "Open all folds" },
      { "zM", [[<cmd>lua require("ufo").closeAllFolds()<cr>]], desc = "Close all folds" },
      { "zr", [[<cmd>lua require("ufo").openFoldsExceptKinds()<cr>]], desc = "Fold less" },
      { "zm", [[<cmd>lua require("ufo").closeFoldsWith()<cr>]], desc = "Fold more" },
    },
  },

  {
    "Wansmer/binary-swap.nvim",
    keys = {
      {
        "<leader>co",
        function()
          require("binary-swap").swap_operands()
        end,
        desc = "Binary swap operands",
        noremap = true,
      },
      {
        "<leader>cO",
        function()
          require("binary-swap").swap_operands_with_operator()
        end,
        desc = "Binary swap operands with operator",
        noremap = true,
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        -- behave like `incsearch`
        incremental = false,
      },
      label = {
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 5,
        },
      },
      -- You can override the default options for a specific mode.
      -- Use it with `require("flash").jump({mode = "forward"})`
      ---@type table<string, Flash.Config>
      modes = {
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          -- show jump labels
          jump_labels = true,
          -- When using jump labels, don't use these keys
          -- This allows using those keys directly after the motion
          label = { exclude = "hjkliardcpqvxy" },
          -- hide after jump when not using jump labels
          autohide = true,
          jump = {
            register = false,
            -- when using jump labels, set to 'true' to automatically jump
            -- or execute a motion when there is only one match
            autojump = false,
          },
        },
      },
      jump = {
        -- clear highlight after jump
        nohlsearch = false,
        -- automatically jump when there is only one match
        autojump = false,
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, false }, -- avoid to conflict with nvim-surround
      { "S", mode = { "n", "x", "o" }, false }, -- avoid to conflict with nvim-surround
      { "r", mode = "o", false }, -- avoid to conflict with coerce.nvim
    },
  },

  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", [[<cmd>lua require("spider").motion("w")<cr>]], mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", [[<cmd>lua require("spider").motion("e")<cr>]], mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", [[<cmd>lua require("spider").motion("b")<cr>]], mode = { "n", "o", "x" }, desc = "Spider-b" },
      { "ge", [[<cmd>lua require("spider").motion("ge")<cr>]], mode = { "n", "o", "x" }, desc = "Spider-ge" },
    },
  },

  {
    "m4xshen/smartcolumn.nvim",
    event = "BufReadPost",
    opts = {
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "nofile",
        "NvimTree",
        "lazy",
        "mason",
        "alpha",
        "dashboard",
        "neo-tree",
        "noice",
      },
    },
  },

  {
    "bloznelis/before.nvim",
    opts = {
      -- How many edit locations to store in memory (default: 10)
      history_size = 42,
    },
    keys = {
      {
        "[<space>",
        function()
          require("before").jump_to_last_edit()
        end,
        desc = "Prev edit",
        noremap = true,
        silent = true,
      },
      {
        "]<space>",
        function()
          require("before").jump_to_next_edit()
        end,
        desc = "Next edit",
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "gbprod/substitute.nvim",
    event = "BufReadPost",
    config = function(_, opts)
      local substitute = require("substitute")
      substitute.setup(opts or {
        on_substitute = require("yanky.integration").substitute(),
      })
      vim.keymap.set("n", "s", substitute.operator, { noremap = true, silent = true })
      vim.keymap.set("n", "ss", substitute.line, { noremap = true, silent = true })
      vim.keymap.set("n", "S", substitute.eol, { noremap = true, silent = true })
      vim.keymap.set("x", "s", substitute.visual, { noremap = true, silent = true })
    end,
  },

  {
    "nacro90/numb.nvim",
    event = "BufReadPost",
    opts = {
      number_only = true,
    },
  },

  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Low priority to catch other plugins' keybindings
    config = true,
  },
}
