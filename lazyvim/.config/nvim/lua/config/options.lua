-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd("language en_US.UTF-8")

-- disable some extension providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- fix newline: CRLF -> LF
vim.opt.fileformat = "unix"

if vim.loop.os_uname().version:match("Windows") then
  if vim.fn.executable("nu") == 1 then
    vim.opt.shell = "nu"
  elseif vim.fn.executable("pwsh") == 1 then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag =
      "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  else
    vim.opt.shell = "powershell"
  end
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- disable some fanzy UI stuff when run in Neovide
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_floating_blur = 0
  vim.g.neovide_floating_opacity = 90
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable Ex-Commands
vim.g.genghis_disable_commands = true

vim.opt.redrawtime = 5000

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#86abdc" })

-- fix python default indents, see :help ft-python-indent
vim.g.python_indent = {
  open_paren = "shiftwidth()",
  continue = "shiftwidth()",
  closed_paren_align_last_line = false,
  searchpair_timeout = 500,
}

vim.o.mousemoveevent = true
vim.o.hidden = false
vim.o.exrc = true
vim.lsp.log.set_level("ERROR")

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
