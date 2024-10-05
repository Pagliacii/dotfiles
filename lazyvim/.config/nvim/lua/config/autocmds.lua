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
    vim.wo.foldlevel = 99 -- fix foldlevel for nvim-ufo
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
    "calendar",
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
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "OverseerList",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>OverseerClose<cr>", { buffer = event.buf, noremap = true, silent = true })
    vim.keymap.del("n", "<C-l>", { buffer = event.buf })
    vim.keymap.del("n", "<C-h>", { buffer = event.buf })
  end,
  once = true,
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "noice" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_user_command("RichTextCopy", function(args)
  local saved_html_use_css = vim.g.html_use_css
  local saved_html_no_progress = vim.g.html_no_progress
  vim.g.html_use_css = false
  vim.g.html_no_progress = false

  -- Create a temporary file to store the HTML content
  local tmp_file = vim.fn.tempname() .. ".html"

  -- Run TOHtml for the selected range
  vim.api.nvim_cmd({
    cmd = "TOhtml",
    range = { args.line1, args.line2 },
    mods = { silent = true, emsg_silent = true },
  }, {})

  -- Restore the original values for html_use_css and html_no_progress
  vim.g.html_use_css = saved_html_use_css
  vim.g.html_no_progress = saved_html_no_progress

  -- Write the output to the temp file
  vim.cmd("w " .. tmp_file)

  -- Close the TOhtml buffer
  vim.cmd.bwipeout({ bang = true })

  -- Open the temp file in the default browser
  if vim.fn.executable("xdg-open") == 1 then
    vim.fn.system({ "xdg-open", tmp_file })
  elseif vim.fn.executable("open") == 1 then
    vim.fn.system({ "open", tmp_file })
  elseif vim.fn.executable("powershell") then
    vim.fn.system({ "powershell.exe", "-NoLogo", "-NoProfile", "-Command", "Start-Process", tmp_file })
  end
end, { range = true })
