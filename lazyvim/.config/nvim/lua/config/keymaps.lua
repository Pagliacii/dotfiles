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

if vim.fn.executable("tmux") == 1 then
  -- tmux
  vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
  vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
  vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
  vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
end

vim.keymap.set("n", "<leader>uu", "<cmd> Telescope undo<CR>", { desc = "visualize undo tree" })
vim.keymap.set("n", "<leader>a", "<cmd> lua require('alpha').start(false)<CR>", { desc = "open dashboard" })

-- Telescope-dap
wk.register({
  ["<leader>t"] = {
    name = "+telescope",
    d = {
      name = "+dap",
      c = { "<cmd> Telescope dap commands<CR>", "commands" },
      f = { "<cmd> Telescope dap frames<CR>", "frames" },
      l = { "<cmd> Telescope dap list_breakpoints<CR>", "breakpoints" },
      s = { "<cmd> Telescope dap configurations<CR>", "configurations" },
      v = { "<cmd> Telescope dap variables<CR>", "variables" },
    },
  },
})

-- Rust
wk.register({
  ["<leader>r"] = {
    name = "+rust",
    c = { "<cmd> RustOpenCargo<CR>", "open Cargo.toml" },
    d = { "<cmd> RustDebuggables<CR>", "debuggable targets" },
    r = { "<cmd> RustRunnables<CR>", "runnable targets" },
  },
})
