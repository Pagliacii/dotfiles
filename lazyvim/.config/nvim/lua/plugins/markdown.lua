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
          { "<leader>mg", "<cmd>Glow<cr>", desc = "Preview in glow", silent = true },
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
      { "<leader>mb", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview in browser", silent = true },
    },
  },
}
