---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>z" representing the "fzf" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params table|nil Optional parameters to pass to the fzf-lua function
---@return table
local key = function(k, cmd, opts, params)
  -- Set defaults for optional parameters
  k = k or ""
  cmd = cmd or ""
  opts = type(opts) == "table" and opts or {}
  params = type(params) == "table" and params or {}

  -- Validate required parameters when not using defaults
  if k == "" and cmd == "" then
    -- Return empty table if no parameters provided
    return {}
  end

  -- Convert table parameters to string representation
  local params_str = ""
  if next(params) ~= nil then
    -- Use vim.inspect with proper formatting for the command
    params_str = vim.inspect(params)
    -- Ensure the string is suitable for command execution
    -- Remove newlines and extra spaces that might cause issues
    params_str = params_str:gsub("%s+", " ")
    params_str = params_str:gsub("%s*,%s*", ", ")
  end

  return vim.tbl_extend("force", {
    ("<leader>z%s"):format(k),
    ("<cmd>lua require('fzf-lua').%s(%s)<cr>"):format(cmd, params_str),
    desc = cmd,
    noremap = true,
    mode = { "n", "x" },
  }, opts)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zs" representing the "fzf > search" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local search_key = function(k, cmd, opts, params)
  return key("s" .. k, cmd, opts, params)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zt" representing the "fzf > tags" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local tags_key = function(k, cmd, opts, params)
  return key("t" .. k, cmd, opts, params)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zg" representing the "fzf > git" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local git_key = function(k, cmd, opts, params)
  return key("g" .. k, cmd, opts, params)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zl" representing the "fzf > lsp" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local lsp_key = function(k, cmd, opts, params)
  return key("l" .. k, cmd, opts, params)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zd" representing the "fzf > dap" group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local dap_key = function(k, cmd, opts, params)
  return key("d" .. k, cmd, opts, params)
end
---Returns a table that can be used as a keybindings in NeoVIM
---With prefix "<leader>zM" representing the "fzf > misc." group
---@param k string
---@param cmd string
---@param opts table|nil
---@param params string|nil Optional parameters to pass to the fzf-lua function
---@return table
local misc_key = function(k, cmd, opts, params)
  return key("M" .. k, cmd, opts, params)
end

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    opts = {
      "telescope",
      global_resume = true,
      global_resume_query = true,
      grep = {
        rg_opts = table.concat({
          "--column",
          "--line-number",
          "--no-heading",
          "--color=always",
          "--smart-case",
          "--max-columns=4096",
          "--hidden",
          "-e",
        }, " "),
      },
      winopts = {
        preview = {
          default = "bat",
          layout = "vertical",
          scrollbar = "float",
        },
        fullscreen = false,
        vertical = "down:45%",
        horizontal = "right:60%",
        hidden = "nohidden",
        on_create = function()
          vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
          vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
        end,
      },
      keymap = {
        builtin = {
          ["ctrl-/"] = "toggle-help",
          ["ctrl-f"] = "toggle-fullscreen",
          ["ctrl-w"] = "toggle-preview-wrap",
          ["ctrl-p"] = "toggle-preview",
          ["ctrl-h"] = "preview-page-up",
          ["ctrl-l"] = "preview-page-down",
          ["ctrl-r"] = "preview-page-reset",
        },
        fzf = {
          ["ctrl-c"] = "abort",
          ["ctrl-w"] = "toggle-preview-wrap",
          ["ctrl-p"] = "toggle-preview",
        },
      },
    },
    keys = {
      --- top-level keys
      key("r", "resume"),
      key("f", "files"),
      key("b", "buffers"),
      key("F", "oldfiles"),
      key("x", "quickfix", { desc = "quickfix list" }),
      key("X", "quickfix_stack", { desc = "quickfix stack" }),
      key("j", "loclist", { desc = "location list" }),
      key("J", "loclist_stack", { desc = "location stack" }),
      key("B", "lines", { desc = "buffer lines" }),
      key("c", "blines", { desc = "currnet buffer lines" }),
      key("T", "tabs"),
      key("A", "args"),
      --- search group keys
      search_key("s", "grep"),
      search_key("s", "grep_visual", { desc = "grep visual", mode = { "v" } }),
      search_key("l", "grep_last", { desc = "grep last" }),
      search_key("w", "grep_cword", { desc = "grep word" }),
      search_key("W", "grep_cWORD", { desc = "grep WORD" }),
      search_key("p", "grep_project", { desc = "grep project" }),
      search_key("b", "lgrep_curbuf", { desc = "live grep (buffer)" }),
      search_key("g", "live_grep", { desc = "live grep (project)" }),
      search_key("G", "live_grep_glob", { desc = "live grep (glob)" }),
      search_key("n", "live_grep_native", { desc = "live grep (native)" }),
      search_key("r", "live_grep_resume", { desc = "live grep resume" }),
      search_key("N", "grep_visual", { desc = "grep" }, { fzf_opts = { ["--layout"] = "default" } }),
      --- tags group keys
      tags_key("t", "tags", { desc = "project" }),
      tags_key("b", "btags", { desc = "buffer" }),
      tags_key("g", "tags_grep", { desc = "grep" }),
      tags_key("g", "tags_grep_visual", { desc = "grep visual", mode = { "v" } }),
      tags_key("w", "tags_grep_cword", { desc = "grep word" }),
      tags_key("W", "tags_grep_cWORD", { desc = "grep WORD" }),
      tags_key("l", "tags_live_grep", { desc = "live grep" }),
      --- git group keys
      git_key("f", "git_files", { desc = "files" }),
      git_key("s", "git_status", { desc = "status" }),
      git_key("c", "git_bcommits", { desc = "commits (buffer)" }),
      git_key("C", "git_commits", { desc = "commits (project)" }),
      git_key("b", "git_branches", { desc = "branches" }),
      git_key("t", "git_stash", { desc = "stash" }),
      --- lsp group keys
      lsp_key("r", "lsp_references", { desc = "references" }),
      lsp_key("d", "lsp_definitions", { desc = "definitions" }),
      lsp_key("D", "lsp_declarations", { desc = "declarations" }),
      lsp_key("t", "lsp_typedefs", { desc = "type definitions" }),
      lsp_key("p", "lsp_implementations", { desc = "implementations" }),
      lsp_key("s", "lsp_document_symbols", { desc = "symbols (document)" }),
      lsp_key("w", "lsp_workspace_symbols", { desc = "symbols (workspace)" }),
      lsp_key("W", "lsp_live_workspace_symbols", { desc = "symbols (workspace live)" }),
      lsp_key("c", "lsp_code_actions", { desc = "code actions" }),
      lsp_key("i", "lsp_incoming_calls", { desc = "calls (incoming)" }),
      lsp_key("o", "lsp_outgoing_calls", { desc = "calls (outgoing)" }),
      lsp_key("f", "lsp_finder", { desc = "finder" }),
      lsp_key("x", "lsp_document_diagnostics", { desc = "diagnostics (document)" }),
      lsp_key("X", "lsp_workspace_diagnostics", { desc = "diagnostics (workspace)" }),
      --- dap group keys
      dap_key("c", "dap_commands", { desc = "commands" }),
      dap_key("s", "dap_configurations", { desc = "configurations" }),
      dap_key("b", "dap_breakpoints", { desc = "breakpoints" }),
      dap_key("f", "dap_frames", { desc = "frames" }),
      --- miscellaneous group keys
      misc_key("b", "builtin"),
      misc_key("p", "profiles"),
      misc_key("h", "help_tags", { desc = "help tags" }),
      misc_key("M", "man_pages", { desc = "man pages" }),
      misc_key("K", "colorschemes", { desc = "color schemes" }),
      misc_key("H", "highlights", { desc = "highlight groups" }),
      misc_key("c", "commands"),
      misc_key("o", "command_history", { desc = "command history" }),
      misc_key("s", "search_history", { desc = "search history" }),
      misc_key("'", "marks"),
      misc_key("j", "jumps"),
      misc_key("C", "changes"),
      misc_key("r", "registers"),
      misc_key("t", "tagstack", { desc = "tag stack" }),
      misc_key("a", "autocmds"),
      misc_key("k", "keymaps"),
      misc_key("f", "filetypes"),
      misc_key("m", "menus"),
      misc_key("S", "spell_suggest", { desc = "spelling suggestions" }),
      misc_key("P", "packadd"),
    },
  },
}
