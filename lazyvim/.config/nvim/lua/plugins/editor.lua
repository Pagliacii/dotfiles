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

  -- disable mini.bufremove
  { "echasnovski/mini.bufremove", enabled = false },

  -- use bdelete instead
  {
    "famiu/bufdelete.nvim",
    -- stylua: ignore
    config = function()
      -- switches to Alpha dashboard when last buffer is closed
      local alpha_on_empty = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BDeletePost*",
        group = alpha_on_empty,
        callback = function(event)
          local fallback_name = vim.api.nvim_buf_get_name(event.buf)
          local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
          local fallback_on_empty = fallback_name == "" and fallback_ft == ""
          if fallback_on_empty then
            require("neo-tree").close_all()
            vim.cmd("Alpha")
            vim.cmd(event.buf .. "bwipeout")
          end
        end,
      })
    end,
    keys = {
      { "<leader>bd", "<CMD>Bdelete<cr>", desc = "Delete Buffer" },
      { "<leader>bD", "<CMD>Bdelete!<cr>", desc = "Delete Buffer (Force)" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = { "BufReadPost" },
    opts = { useDefaultKeymaps = true },
  },

  {
    "ziontee113/syntax-tree-surfer",
    event = { "BufReadPost" },
    keys = function()
      -- Syntax Tree Surfer
      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set(
        "n",
        "vU",
        "<cmd>STSSwapCurrentNodeNextNormal<cr>",
        { silent = true, expr = true, desc = "Swap cursor node up" }
      )
      vim.keymap.set(
        "n",
        "vD",
        "<cmd>STSSwapCurrentNodePrevNormal<cr>",
        { silent = true, expr = true, desc = "Swap cursor node down" }
      )

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      vim.keymap.set(
        "n",
        "vd",
        "<cmd>STSSwapCurrentNodeNextNormal<cr>",
        { silent = true, expr = true, desc = "Swap current node (next)" }
      )
      vim.keymap.set(
        "n",
        "vd",
        "<cmd>STSSwapCurrentNodePrevNormal<cr>",
        { silent = true, expr = true, desc = "Swap current node (prev)" }
      )

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
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      mappings = {
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },

  {
    "echasnovski/mini.operators",
    version = false,
    event = "VeryLazy",
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
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    config = function()
      vim.o.startofline = true
      require("origami").setup({
        setupFoldKeymaps = false,
      })
    end,
    keys = function()
      local function normal(cmdStr)
        vim.cmd.normal({ cmdStr, bang = true })
      end
      local origami = require("origami")
      local excluded_filetypes = { "neo-tree" }
      vim.keymap.set("n", "h", function()
        if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
          normal("h")
        else
          origami.h()
        end
      end)
      vim.keymap.set("n", "l", function()
        if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
          normal("l")
        else
          origami.l()
        end
      end)
    end,
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
        rainbow = {
          enabled = true,
        },
      },
      modes = {
        char = {
          jump_labels = true,
        },
      },
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
}
