-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ok, wk = pcall(require, "which-key")

-- Groups
if ok then
  wk.add({
    { "<leader>A", group = "Aha!" },
    { "<leader>B", group = "browse" },
    { "<leader>D", group = "devdocs" },
    { "<leader>G", group = "go" },
    { "<leader>H", group = "harpoon" },
    { "<leader>K", group = "keymap" },
    { "<leader>M", group = "markdown" },
    { "<leader>P", group = "picker" },
    { "<leader>Pi", group = "icon" },
    { "<leader>S", group = "snippet" },
    { "<leader>UC", group = "color code" },
    { "<leader>W", group = "wezterm" },
    { "<leader>cR", group = "refactoring" },
    { "<leader>dL", group = "log" },
    { "<leader>du", group = "ui" },
    { "<leader>gu", group = "gitui" },
    { "<leader>gv", group = "verco" },
    { "<leader>k", group = "lspsaga" },
    { "<leader>n", group = "note" },
    { "<leader>nC", group = "count" },
    { "<leader>nE", group = "export" },
    { "<leader>nG", group = "global" },
    { "<leader>nI", group = "import" },
    { "<leader>nL", group = "list" },
    { "<leader>nc", group = "cwd" },
    { "<leader>nj", group = "jump" },
    { "<leader>nl", group = "line" },
    { "<leader>nt", group = "typst" },
    { "<leader>p", group = "python" },
    { "<leader>r", group = "rust" },
    { "<leader>t", group = "telescope" },
    { "<leader>y", group = "yank" },
    { "<localleader>r", group = "run" },
    { "gp", group = "peek" },
    { "gz", hidden = true },
    {
      mode = { "n", "v" },
      { "<leader>F", group = "fzf" },
      { "<leader>Fd", group = "dap" },
      { "<leader>Fg", group = "git" },
      { "<leader>Fl", group = "lsp" },
      { "<leader>Fm", group = "misc" },
      { "<leader>Fs", group = "search" },
      { "<leader>Ft", group = "tags" },
      { "<leader>T", group = "terminal" },
      { "<leader>TS", group = "send" },
      { "<leader>U", group = "util" },
    },
  })
end

-- Unset LazyVim's default bindings
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

if vim.fn.executable("gitui") == 1 then
  vim.keymap.set("n", "<leader>guG", function()
    LazyVim.terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
  end, { desc = "gitui (cwd)" })
  vim.keymap.set("n", "<leader>gug", function()
    LazyVim.terminal.open({ "gitui" }, { cwd = LazyVim.root.get(), esc_esc = false, ctrl_hjkl = false })
  end, { desc = "gitui (root dir)" })
end

if vim.fn.executable("verco") == 1 then
  vim.keymap.set("n", "<leader>gvG", function()
    LazyVim.terminal.open({ "verco" })
  end, { desc = "verco (cwd)" })
  vim.keymap.set("n", "<leader>gvg", function()
    LazyVim.terminal.open({ "verco" }, { cwd = require("lazyvim.util").root.get() })
  end, { desc = "verco (root dir)" })
end

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>Ub", function()
    LazyVim.terminal.open({ "btop" })
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
