-- Workaround for nvim v0.12-dev: vim.treesitter.get_parser() may return nil
-- instead of throwing an error when no parser is available (behavior change
-- around dev-2582). Some plugins (rainbow-delimiters, treesitter-context,
-- null-ls todo_comments) don't handle nil and crash.
-- Returns a stub parser with safe method return values.
-- TODO: Remove once plugins add nil checks upstream.
if not vim.g._ts_get_parser_patched then
  vim.g._ts_get_parser_patched = true
  local _get_parser = vim.treesitter.get_parser
  local function noop() end
  local function children() return {} end
  local function parse() return {} end
  local noop_parser_mt = {
    __index = function(t, key)
      if key == "lang" then
        return function() return rawget(t, "_lang") end
      end
      if key == "children" then return children end
      if key == "parse" then return parse end
      return noop
    end,
  }
  vim.treesitter.get_parser = function(bufnr, lang, opts)
    local ok, parser = pcall(_get_parser, bufnr, lang, opts)
    if ok then
      if parser then return parser end
      -- v0.12-dev >=2582: returns nil, no parser available
      return setmetatable({ _lang = lang }, noop_parser_mt)
    end
    -- v0.12-dev <2582 or stable: throws error on no parser
    -- Only stub for the expected "no parser" error; re-throw others
    -- at level 2 so the traceback points to the caller, not this wrapper
    if type(parser) == "string" and parser:match("[Pp]arser could not be created") then
      return setmetatable({ _lang = lang }, noop_parser_mt)
    end
    error(parser, 2)
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
