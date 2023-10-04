local filetypes = { "markdown" }
return {
  {
    "ellisonleao/glow.nvim",
    config = true,
    ft = filetypes,
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
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = filetypes,
    cmd = { "MarkdownPreviewToggle" },
    keys = {
      { "<leader>Mb", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview in browser", silent = true },
    },
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
    ft = filetypes,
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
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.hover.dictionary,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "glow",
        "markdown-toc",
        "prettierd",
        "write-good",
      })
    end,
  },

  {
    "richardbizik/nvim-toc",
    ft = filetypes,
    config = true,
    cmd = { "TOC" },
  },
}
