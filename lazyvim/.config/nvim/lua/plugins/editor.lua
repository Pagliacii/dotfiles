return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = true,
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
}
