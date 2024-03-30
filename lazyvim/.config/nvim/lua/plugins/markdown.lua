local filetypes = { "markdown" }
return {
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = { "Glow" },
    keys = function(_, keys)
      if vim.fn.executable("glow") == 1 then
        vim.list_extend(keys, {
          { "<leader>Mg", "<cmd>Glow<cr>", desc = "Preview in glow", silent = true },
        })
      end
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = function()
      return {
        {
          "<leader>Mb",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Preview in browser",
          silent = true,
        },
      }
    end,
  },

  {
    "AckslD/nvim-FeMaco.lua",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      ensure_newline = function()
        return true
      end,
      post_open_float = function()
        vim.wo.signcolumn = "no"
        vim.keymap.set("n", "q", "<C-w><C-q>", { buffer = 0, silent = true })
      end,
    },
    cmd = { "FeMaco" },
    keys = {
      { "<leader>Mf", "<cmd>FeMaco<cr>", desc = "Edit code block", noremap = true },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.hover.dictionary,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "glow",
        "markdown-toc",
        "prettierd",
        "write-good",
      })
    end,
  },

  {
    "richardbizik/nvim-toc",
    config = true,
    cmd = { "TOC" },
  },

  {
    "HakonHarnes/img-clip.nvim",
    ft = filetypes,
    event = "BufEnter",
    opts = {},
    keys = {
      { "<leader>Mp", "<cmd>PasteImage<cr>", desc = "Paste clipboard image", noremap = true },
    },
  },
}
