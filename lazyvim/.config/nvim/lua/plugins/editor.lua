return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            "node_modules",
            "__pycache__",
          },
          hide_by_pattern = {
            "*.pyc",
            "*.orig",
            "*.rej",
          },
          never_show = {
            ".DS_Store",
          },
        },
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufReadPost",
    config = true,
  },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = { "BufReadPost" },
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = { "r", "R", "gw", "gc" },
    },
  },

  {
    "ziontee113/syntax-tree-surfer",
    event = { "BufReadPost" },
    config = true,
    keys = function()
      -- Syntax Tree Surfer
      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vU", function()
        vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        return "g@l"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Swap cursor node up" }))
      vim.keymap.set("n", "vD", function()
        vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        return "g@l"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Swap cursor node down" }))

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vd", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        return "g@l"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Swap current node (next)" }))
      vim.keymap.set("n", "vu", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        return "g@l"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Swap current node (prev)" }))

      -- Visual Selection from Normal Mode
      vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
      vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
      vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
      vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
      vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
      vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
    end,
  },

  {
    "echasnovski/mini.operators",
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
    event = "BufReadPost",
    config = true,
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
    opts = {
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
          label = { exclude = "hjkliardcpxy" },
        },
      },
    },
    keys = {
      { "s", false }, -- avoid to conflict with nvim-surround
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
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      filetypes_denylist = {
        "dashboard",
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
    "ThePrimeagen/harpoon",
    opts = {
      excluded_filetypes = {
        "harpoon",
        "dap-repl",
        "dap-float",
        "dap-terminal",
        "terminal",
        "toggleterm",
        "alpha",
        "dashboard",
      },
    },
    keys = function()
      return {
        {
          "<leader>Ht",
          function()
            local harpoon = require("harpoon")
            local conf = require("telescope.config").values
            local file_paths = {}
            for _, item in ipairs(harpoon:list().items) do
              table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
              .new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                  results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
              })
              :find()
          end,
          desc = "Open harpoon window",
          noremap = true,
        },
        {
          "<leader>H;",
          function()
            require("harpoon"):list():append()
          end,
          desc = "Toggle mark",
          noremap = true,
        },
        {
          "<leader>Hm",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Quick menu",
          noremap = true,
        },
        {
          "<leader>H1",
          function()
            require("harpoon"):list():select(1)
          end,
          desc = "Harpoon to File 1",
        },
        {
          "<leader>H2",
          function()
            require("harpoon"):list():select(2)
          end,
          desc = "Harpoon to File 2",
        },
        {
          "<leader>H3",
          function()
            require("harpoon"):list():select(3)
          end,
          desc = "Harpoon to File 3",
        },
        {
          "<leader>H4",
          function()
            require("harpoon"):list():select(4)
          end,
          desc = "Harpoon to File 4",
        },
        {
          "<leader>H5",
          function()
            require("harpoon"):list():select(5)
          end,
          desc = "Harpoon to File 5",
        },
        {
          "<leader>Hk",
          function()
            require("harpoon"):list():prev()
          end,
          desc = "Prev mark",
          noremap = true,
        },
        {
          "<leader>Hj",
          function()
            require("harpoon"):list():next()
          end,
          desc = "Next mark",
          noremap = true,
        },
      }
    end,
  },
}
