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
    "johmsalas/text-case.nvim",
    event = "BufReadPost",
    config = true,
  },
}
