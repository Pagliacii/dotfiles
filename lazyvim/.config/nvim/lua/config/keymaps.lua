-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ok, wk = pcall(require, "which-key")

-- Groups
if ok then
  wk.register({
    ["<leader>r"] = { name = "+rust" },
    ["<leader>P"] = {
      name = "+picker",
      i = { name = "+icon" },
    },
    ["<leader>M"] = { name = "+markdown" },
    ["<leader>N"] = {
      name = "+note",
      c = { name = "+cwd" },
      g = { name = "+global" },
      l = { name = "+line" },
      j = { name = "+jump" },
      C = { name = "+count" },
      E = { name = "+export" },
      I = { name = "+import" },
      L = { name = "+list" },
    },
    ["<leader>G"] = { name = "+go" },
    ["<leader>du"] = { name = "+ui" },
    ["<leader>U"] = {
      name = "+util",
      mode = { "n", "v" },
    },
    ["<leader>t"] = { name = "+telescope" },
    ["gz"] = "which_key_ignore",
    ["<leader>gu"] = { name = "+gitui" },
    ["<leader>gv"] = { name = "+verco" },
    ["<leader>T"] = {
      name = "+terminal",
      mode = { "n", "v" },
      S = { name = "+send" },
    },
    ["<leader>k"] = { name = "+lspsaga" },
    ["gp"] = { name = "+preview" },
    ["<leader>p"] = { name = "+python" },
    ["<leader>F"] = {
      name = "+fzf",
      mode = { "n", "v" },
      d = { name = "+dap" },
      g = { name = "+git" },
      l = { name = "+lsp" },
      m = { name = "+misc" },
      s = { name = "+search" },
      t = { name = "+tags" },
    },
    ["<leader>B"] = { name = "+browse" },
    ["<leader>D"] = { name = "+devdocs" },
    ["<leader>W"] = { name = "+wezterm" },
    ["<leader>y"] = { name = "+yank" },
    ["<leader>R"] = { name = "+run" },
    ["<leader>S"] = { name = "+snippet" },
  })
end

-- Unset LazyVim's default bindings
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

if vim.fn.executable("gitui") == 1 then
  vim.keymap.set("n", "<leader>guG", function()
    require("lazyvim.util").terminal.open({ "gitui" })
  end, { desc = "gitui (cwd)" })
  vim.keymap.set("n", "<leader>gug", function()
    require("lazyvim.util").terminal.open({ "gitui" }, { cwd = require("lazyvim.util").root.get() })
  end, { desc = "gitui (root dir)" })
end

if vim.fn.executable("verco") == 1 then
  vim.keymap.set("n", "<leader>gvG", function()
    require("lazyvim.util").terminal.open({ "verco" })
  end, { desc = "verco (cwd)" })
  vim.keymap.set("n", "<leader>gvg", function()
    require("lazyvim.util").terminal.open({ "verco" }, { cwd = require("lazyvim.util").root.get() })
  end, { desc = "verco (root dir)" })
end

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>Ub", function()
    require("lazyvim.util").terminal.open({ "btop" })
  end, { desc = "btop" })
end

-- Keey your register clean from `dd`
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })

vim.keymap.set("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

vim.keymap.set("n", "<leader>yf", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "File abspath" })
vim.keymap.set("n", "<leader>yF", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("+", filename)
  vim.notify('Copied "' .. filename .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "File name" })
vim.keymap.set("n", "<leader>yb", function()
  local filename = vim.fn.expand("%:t:r")
  vim.fn.setreg("+", filename)
  vim.notify('Copied "' .. filename .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "File name w/o ext" })
vim.keymap.set("n", "<leader>yd", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify('Copied "' .. dir .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "Dir abspath" })
vim.keymap.set("n", "<leader>yD", function()
  local dir = vim.fn.expand("%:h:t")
  vim.fn.setreg("+", dir)
  vim.notify('Copied "' .. dir .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "Dir name" })
vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "File relpath" })
vim.keymap.set("n", "<leader>yR", function()
  local dir = vim.fn.expand("%:h")
  vim.fn.setreg("+", dir)
  vim.notify('Copied "' .. dir .. '" to clipboard!', vim.log.levels.INFO)
end, { desc = "Dir relpath" })
