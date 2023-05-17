-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto change to opened directory
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("lcd %:p:h")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("set fo-=c fo-=r fo-=o")
  end,
})

-- Telescope.nvim previewer wraps long lines
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.cmd("setlocal wrap")
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-float",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-terminal",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bdelete!<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "DiffviewFiles",
  },
  callback = function(event)
    vim.diagnostic.disable(event.buf)
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Lsp inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
  desc = "Lsp inlay hints",
  pattern = { "*.go" },
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "rust_analyzer" then
      return
    end
    require("lsp-inlayhints").on_attach(client, bufnr, true)
  end,
})
