-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto change to opened directory
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("BufEnter"),
  callback = function()
    vim.cmd("lcd %:p:h")
  end,
})

-- Telescope.nvim previewer wraps long lines
vim.api.nvim_create_autocmd("User", {
  group = augroup("telescope.nvim"),
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.cmd("setlocal wrap")
  end,
})
