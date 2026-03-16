-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ok, wk = pcall(require, "which-key")

-- Groups
if ok then
  wk.add({
    { "<leader>p", group = "programming", icon = { icon = "󰘦 ", color = "blue" } },
    { "<leader>pb", group = "browse", icon = { icon = "󰦄 ", hl = "Keyword" } },
    { "<leader>pd", group = "devdocs", icon = { icon = "󱁤 ", color = "white" } },
    { "<leader>pr", group = "rust", icon = { icon = "󱘗 ", color = "orange" } },
    { "<leader>pg", group = "go", icon = { icon = " ", color = "blue" } },
    { "<leader>ph", group = "rest", icon = { icon = "🐼 ", color = "azure" } },
    { "<leader>py", group = "python", icon = { icon = " ", color = "blue" } },
    { "<leader>m", group = "markdown", icon = { icon = " ", color = "black" } },
    { "<leader>dL", group = "log", icon = { icon = " ", color = "green" } },
    { "<leader>du", group = "ui", icon = { icon = "󰕮 ", color = "azure" } },
    { "<leader>gc", group = "conflict", icon = { icon = " ", color = "yellow" } },
    { "<leader>gd", group = "diff", icon = { icon = " ", color = "green" } },
    { "<leader>gn", group = "Neogit", icon = { icon = " ", color = "orange" } },
    { "<leader>gu", group = "gitui", icon = { icon = " ", color = "purple" } },
    { "<leader>gv", group = "verco", icon = { icon = " ", color = "purple" } },
    { "<leader>gO", group = "octo", icon = { icon = "🐙 ", color = "red" } },
    { "<leader>no", group = "neorg", icon = { icon = " ", color = "orange" } },
    { "<leader>nt", group = "typst", icon = { icon = "󰼭 ", color = "orange" } },
    { "<leader>t", group = "telescope" },
    { "<leader>h", group = "hover", icon = { icon = " ", color = "red" } },
    { "<leader>y", group = "yazi", icon = { icon = "🦆 ", color = "cyan" } },
    { "<leader>v", group = "tools", icon = { icon = "󰦭 ", color = "yellow" } },
    { "<leader>i", group = "inspect", icon = { icon = "🔍", color = "azure" } },
    { "<leader>o", group = "overseer", icon = { icon = "󰑮 ", color = "green" } },
    {
      mode = { "n", "v" },
      { "<leader>a", group = "AI", icon = { icon = "🤖 ", color = "black" } },
      { "<leader>j", group = "jots", icon = { icon = "🔫 ", color = "azure" } },
      { "<leader>k", group = "lspsaga", icon = { icon = " ", color = "purple" } },
      { "<leader>n", group = "note", icon = { icon = "󱞁 ", color = "orange" } },
      { "<leader>z", group = "fzf", icon = { icon = "󰈞 ", color = "blue" } },
      { "<leader>zd", group = "dap", icon = { icon = " ", color = "purple" } },
      { "<leader>zg", group = "git", icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>zl", group = "lsp", icon = { icon = " ", color = "yellow" } },
      { "<leader>zo", group = "overlay", icon = { icon = "󰌨 ", color = "cyan" } },
      { "<leader>zM", group = "misc", icon = { icon = " ", color = "blue" } },
      { "<leader>zs", group = "search", icon = { icon = " ", color = "green" } },
      { "<leader>zt", group = "tags", icon = { icon = " ", color = "red" } },
      { "<leader>cT", group = "treesitter", icon = { icon = " ", color = "green" } },
      { "<leader>nb", group = "obsidian", icon = { icon = "📝 ", color = "purple" } },
    },
  })
end

-- Unset LazyVim's default bindings
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>vb", function()
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
vim.keymap.set("n", "gw", "*N", { desc = "Search word under cursor" })
