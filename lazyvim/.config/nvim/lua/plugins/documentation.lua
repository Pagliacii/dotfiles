return {
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      previewer_cmd = "glow",
      cmd_args = { "-s", "dark", "-w", "80" },
      picker_cmd = true,
      after_open = function(bufnr)
        -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><Esc>", true, false, true), "t", false)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<cr>", { silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":close<cr>", { silent = true })
      end,
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
      "DevdocsOpenCurrentFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
    keys = {
      { "<leader>Di", "<cmd>DevdocsInstall<cr>", desc = "Install docs", noremap = true, silent = true },
      { "<leader>Du", "<cmd>DevdocsUninstall<cr>", desc = "Uninstall docs", noremap = true, silent = true },
      {
        "<leader>Do",
        "<cmd>DevdocsOpenCurrentFloat<cr>",
        desc = "Open docs (current)",
        noremap = true,
        silent = true,
      },
      { "<leader>DO", "<cmd>DevdocsOpenFloat<cr>", desc = "Open docs (all)", noremap = true, silent = true },
      { "<leader>DU", "<cmd>DevdocsUpdate<cr>", desc = "Update docs", noremap = true, silent = true },
      { "<leader>DF", "<cmd>DevdocsFetch<cr>", desc = "Fetch metadata", noremap = true, silent = true },
    },
  },

  {
    "crispgm/telescope-heading.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("heading")
    end,
    keys = {
      { "<leader>tH", "<cmd>Telescope heading theme=dropdown<cr>", desc = "Headings", noremap = true },
    },
  },

  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown", "norg", "org" },
    opts = {},
    keys = {
      { "<leader>Da", ":lua require('otter').activate()<cr>", desc = "Otter", noremap = true, silent = true },
    },
  },
}
