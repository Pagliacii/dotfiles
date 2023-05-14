return {
  {
    "christoomey/vim-tmux-navigator",
    keys = function(_, keys)
      if vim.fn.executable("tmux") == 1 then
        vim.list_extend(keys, {
          { "<C-h>", "<cmd> TmuxNavigateLeft<CR>",  desc = "Window left" },
          { "<C-l>", "<cmd> TmuxNavigateRight<CR>", desc = "Window right" },
          { "<C-j>", "<cmd> TmuxNavigateDown<CR>",  desc = "Window down" },
          { "<C-k>", "<cmd> TmuxNavigateUp<CR>",    desc = "Window up" },
        })
      end
    end,
  },

  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    config = function()
      local orgmode = require("orgmode")
      orgmode.setup_ts_grammar()
      orgmode.setup({})
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd> DiffviewOpen<CR>", desc = "Open Diffview" },
    },
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        require("hover.providers.dictionary")
      end
    },
    keys = {
      {
        "<leader>yd",
        function()
          require("hover").hover()
        end,
        desc = "Lookup word under cursor in dictionary"
      }
    }
  },

  {
    "voldikss/vim-translator",
    keys = {
      { "<leader>yw", "<cmd>TranslateW<CR>", mode = { "n", "v" }, desc = "Display translation in window" },
    }
  },
}
