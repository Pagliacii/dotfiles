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
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("VimEnter"),
  callback = function()
    vim.cmd("lcd %:p:h")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("BufEnter"),
  callback = function()
    vim.cmd("set fo-=c fo-=r fo-=o")
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

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("ui"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("dap"),
  pattern = {
    "dap-float",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("dap"),
  pattern = {
    "dap-terminal",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bdelete!<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("Diffview"),
  pattern = {
    "DiffviewFiles",
  },
  callback = function(event)
    vim.diagnostic.disable(event.buf)
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Fix Golang imports
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("fix_go_imports"),
  pattern = "*.go",
  callback = function()
    -- ensure imports are sorted and grouped correctly
    local wait_ms = 1000
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
})

-- Lsp inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
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
