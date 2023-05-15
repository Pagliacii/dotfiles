-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

if vim.fn.executable("gitui") == 1 then
  wk.register({
    ["<leader>gu"] = {
      name = "+gitui",
      G = {
        function()
          require("lazyvim.util").float_term({ "gitui" })
        end,
        "gitui (cwd)",
      },
      g = {
        function()
          require("lazyvim.util").float_term({ "gitui" }, { cwd = require("lazyvim.util").get_root() })
        end,
        "gitui (root dir)",
      }
    },
  })
end

if vim.fn.executable("verco") == 1 then
  wk.register({
    ["<leader>gv"] = {
      name = "+verco",
      G = {
        function()
          require("lazyvim.util").float_term({ "verco" })
        end,
        "verco (cwd)",
      },
      g = {
        function()
          require("lazyvim.util").float_term({ "verco" }, { cwd = require("lazyvim.util").get_root() })
        end,
        "verco (root dir)",
      }
    },
  })
end

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>xb", function()
    require("lazyvim.util").float_term({ "btop" })
  end, { desc = "btop" })
end

vim.keymap.set("n", "<leader>a", "<cmd> lua require('alpha').start(false)<cr>", { desc = "Open Dashboard" })

-- Groups
wk.register({
  ["<leader>t"] = {
    name = "+telescope",
    d = { name = "+dap" },
  },
  ["<leader>r"] = { name = "+rust" },
  ["<leader>y"] = { name = "+dictionary" },
  ["<leader>S"] = { name = "+focus" },
  ["<leader>p"] = {
    name = "+picker",
    i = { name = "+icon" },
  },
  ["<leader>m"] = { name = "+markdown" },
})
