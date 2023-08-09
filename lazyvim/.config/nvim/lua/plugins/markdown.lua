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
    "jose-elias-alvarez/null-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.formatting.markdown_toc,
        null_ls.builtins.formatting.prettierd.with({
          filetypes = filetypes,
        }),
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
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "norg",
      "text",
    },
    config = function()
      require("autolist").setup()

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
      vim.keymap.set("n", "<C-R>", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>Mn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>Mp", require("autolist").cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },

  {
    "richardbizik/nvim-toc",
    ft = filetypes,
    config = true,
    cmd = { "TOC" },
  },
}
