-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

if vim.fn.executable("gitui") == 1 then
  vim.keymap.set("n", "<leader>gug", function()
    require("lazyvim.util").float_term({ "gitui" })
  end, { desc = "gitui (cwd)" })
  vim.keymap.set("n", "<leader>guG", function()
    require("lazyvim.util").float_term({ "gitui" }, { cwd = require("lazyvim.util").get_root() })
  end, { desc = "gitui (root dir)" })
end

if vim.fn.executable("verco") == 1 then
  vim.keymap.set("n", "<leader>gvg", function()
    require("lazyvim.util").float_term({ "verco" })
  end, { desc = "verco (cwd)" })
  vim.keymap.set("n", "<leader>gvG", function()
    require("lazyvim.util").float_term({ "verco" }, { cwd = require("lazyvim.util").get_root() })
  end, { desc = "verco (root dir)" })
end

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>xb", function()
    require("lazyvim.util").float_term({ "btop" })
  end, { desc = "btop" })
end

vim.keymap.set("n", "<leader>a", "<cmd> lua require('alpha').start(false)<CR>", { desc = "Open Dashboard" })

-- Groups
wk.register({
  ["<leader>t"] = {
    name = "+telescope",
    d = { name = "+dap" },
  },
  ["<leader>r"] = { name = "+rust" },
})
