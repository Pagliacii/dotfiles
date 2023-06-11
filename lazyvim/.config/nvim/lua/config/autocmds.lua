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
local set_working_dir = vim.api.nvim_create_augroup("SetWorkingDirectory", { clear = false })
vim.api.nvim_create_autocmd("VimEnter", {
  group = set_working_dir,
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd("tcd %:p:h")
    end
  end,
})
vim.api.nvim_create_autocmd("TabNewEntered", {
  group = set_working_dir,
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd("tcd %:p:h")
    end
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
    "dap-repl",
    "toggleterm",
    "query",
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
    "Octo",
  },
  callback = function(event)
    vim.diagnostic.disable(event.buf)
    vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = event.buf, silent = true })
  end,
})

--- Fix Golang imports
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Fix golang imports",
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
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name ~= "rust_analyzer" then
      require("lsp-inlayhints").on_attach(client, bufnr, true)
    end
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "FileType" }, {
  pattern = { "term://*", "toggleterm" },
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "q", "<cmd>ToggleTerm<cr>", opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "json",
  },
  callback = function(event)
    -- When creating a new line with o, make sure there is a trailing comma on the current line
    vim.keymap.set("n", "o", function()
      local line = vim.api.nvim_get_current_line()

      local should_add_comman = string.find(line, "[^,{[]$")
      if should_add_comman then
        return "A,<cr>"
      else
        return "o"
      end
    end, { buffer = event.buf, expr = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sql",
  },
  callback = function(event)
    vim.keymap.set("n", "<cr>", "<cmd>write<cr>", { buffer = event.buf })
  end,
})

local persisted_folds = vim.api.nvim_create_augroup("PersistedFolds", { clear = false })
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = persisted_folds,
  pattern = "*.*",
  callback = function()
    vim.cmd([[mkview]])
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = persisted_folds,
  pattern = "*.*",
  callback = function()
    vim.cmd([[silent! loadview]])
  end,
})
