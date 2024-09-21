-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ok, wk = pcall(require, "which-key")

-- Groups
if ok then
  wk.add({
    { "<leader>A", group = "Aha!", icon = { icon = " ", color = "yellow" } },
    { "<leader>B", group = "browse", icon = { icon = "󰦄 ", hl = "Keyword" } },
    { "<leader>D", group = "devdocs", icon = { icon = "󱁤 ", color = "white" } },
    { "<leader>G", group = "go", icon = { icon = " ", color = "blue" } },
    { "<leader>H", group = "harpoon", icon = { icon = "󰎐 ", color = "cyan" } },
    { "<leader>K", group = "keymap", icon = { icon = "󰌌 ", color = "green" } },
    { "<leader>M", group = "markdown", icon = { icon = " ", color = "black" } },
    { "<leader>O", group = "octo", icon = { icon = "🐙 ", color = "red" } },
    { "<leader>P", group = "picker", icon = { icon = " ", color = "purple" } },
    { "<leader>Pi", group = "icon", icon = { icon = "󱊒 ", color = "red" } },
    { "<leader>R", group = "Rest", icon = { icon = "🐼 ", color = "azure" } },
    { "<leader>UC", group = "color code", icon = { icon = " ", color = "grey" } },
    { "<leader>W", group = "wezterm", icon = { icon = " ", color = "purple" } },
    { "<leader>cR", group = "refactoring", icon = { icon = " ", color = "orange" } },
    { "<leader>dL", group = "log", icon = { icon = " ", color = "green" } },
    { "<leader>du", group = "ui", icon = { icon = "󰕮 ", color = "azure" } },
    { "<leader>gc", group = "conflict", icon = { icon = " ", color = "yellow" } },
    { "<leader>gn", group = "Neogit", icon = { icon = " ", color = "orange" } },
    { "<leader>gu", group = "gitui", icon = { icon = " ", color = "purple" } },
    { "<leader>gv", group = "verco", icon = { icon = " ", color = "purple" } },
    { "<leader>k", group = "lspsaga", icon = { icon = " ", color = "purple" } },
    { "<leader>n", group = "note", icon = { icon = "󱞁 ", color = "orange" } },
    { "<leader>nC", group = "count", icon = { icon = "󰆙 ", color = "orange" } },
    { "<leader>nE", group = "export", icon = { icon = "󰈝 ", color = "orange" } },
    { "<leader>nG", group = "global", icon = { icon = "󰣩 ", color = "orange" } },
    { "<leader>nI", group = "import", icon = { icon = "󰈠 ", color = "orange" } },
    { "<leader>nL", group = "list", icon = { icon = "󱒋 ", color = "orange" } },
    { "<leader>nc", group = "cwd", icon = { icon = "󰈔 ", color = "orange" } },
    { "<leader>nj", group = "jump", icon = { icon = " ", color = "orange" } },
    { "<leader>nl", group = "line", icon = { icon = " ", color = "orange" } },
    { "<leader>nt", group = "typst", icon = { icon = "󰼭 ", color = "orange" } },
    { "<leader>nz", group = "telekasten", icon = { icon = "📔 ", color = "green" } },
    { "<leader>p", group = "python", icon = { icon = " ", color = "blue" } },
    { "<leader>r", group = "rust", icon = { icon = "󱘗 ", color = "orange" } },
    { "<leader>t", group = "telescope" },
    { "<leader>y", group = "yank", icon = { icon = "󰆏 ", color = "cyan" } },
    { "gp", group = "peek", icon = { icon = " ", color = "azure" } },
    {
      mode = { "n", "v" },
      { "<leader>a", group = "AI", icon = { icon = "🤖 ", color = "black" } },
      { "<leader>F", group = "fzf", icon = { icon = "󰈞 ", color = "blue" } },
      { "<leader>Fd", group = "dap", icon = { icon = " ", color = "purple" } },
      { "<leader>Fg", group = "git", icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>Fl", group = "lsp", icon = { icon = " ", color = "yellow" } },
      { "<leader>Fo", group = "overlay", icon = { icon = "󰌨 ", color = "cyan" } },
      { "<leader>FM", group = "misc.", icon = { icon = " ", color = "blue" } },
      { "<leader>Fs", group = "search", icon = { icon = " ", color = "green" } },
      { "<leader>Ft", group = "tags", icon = { icon = " ", color = "red" } },
      { "<leader>S", group = "snippet", icon = { icon = " ", color = "azure" } },
      { "<leader>T", group = "terminal" },
      { "<leader>TS", group = "send" },
      { "<leader>U", group = "util", icon = { icon = "󰦭 ", color = "yellow" } },
    },
    { "<leader>o", group = "overseer", icon = { icon = "󰑮 ", color = "green" } },
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
vim.keymap.set("n", "i", "zzi", { desc = "Center screen on cursor" })
vim.keymap.set("n", "a", "zza", { desc = "Center screen on cursor" })
vim.keymap.set("n", "o", "zzo", { desc = "Center screen on cursor" })

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
