local filetypes = { "markdown" }
local leader_key = "<leader>m"

vim.keymap.set("n", leader_key .. "m", function()
  if vim.fn.executable("markmap") == 1 then
    local cmd = vim.fn.exepath("markmap")
    -- Create a temporary file to store the HTML content
    local tmp_file = vim.fn.tempname() .. ".html"
    local ret = vim.system({ cmd, "--offline", "--output", tmp_file, vim.fn.expand("%:p") }, { text = true })
    vim.print(ret.cmd)
  end
end, { desc = "Markmap", silent = true, noremap = true })

return {
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = { "Glow" },
    keys = function(_, keys)
      if vim.fn.executable("glow") == 1 then
        vim.list_extend(keys, {
          { leader_key .. "g", "<cmd>Glow<cr>", desc = "Preview in glow", silent = true },
        })
      end
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = function()
      return {
        {
          leader_key .. "b",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Preview in browser",
          silent = true,
        },
      }
    end,
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
        "markmap-cli",
        "prettierd",
        "write-good",
      })
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    ft = filetypes,
    event = "BufReadPre",
    opts = {},
    keys = {
      { leader_key .. "p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image", noremap = true },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = false,
        icons = { "◉ ", "○ ", "◆ ", "◇ ", "★ ", "✸ " },
      },
      code = {
        sign = false,
        left_pad = 2,
        right_pad = 2,
        width = "block",
      },
    },
  },
}
