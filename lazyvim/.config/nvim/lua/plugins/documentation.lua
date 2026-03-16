local prefix = "<leader>pd"

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
      { prefix .. "i", "<cmd>DevdocsInstall<cr>", desc = "Install docs", noremap = true, silent = true },
      { prefix .. "u", "<cmd>DevdocsUninstall<cr>", desc = "Uninstall docs", noremap = true, silent = true },
      {
        prefix .. "o",
        "<cmd>DevdocsOpenCurrentFloat<cr>",
        desc = "Open docs (current)",
        noremap = true,
        silent = true,
      },
      { prefix .. "O", "<cmd>DevdocsOpenFloat<cr>", desc = "Open docs (all)", noremap = true, silent = true },
      { prefix .. "U", "<cmd>DevdocsUpdate<cr>", desc = "Update docs", noremap = true, silent = true },
      { prefix .. "F", "<cmd>DevdocsFetch<cr>", desc = "Fetch metadata", noremap = true, silent = true },
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
      { prefix .. "a", ":lua require('otter').activate()<cr>", desc = "Otter", noremap = true, silent = true },
    },
  },
}
