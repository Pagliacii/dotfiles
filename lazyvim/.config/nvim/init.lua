-- Workaround for Neovim v0.12+: vim.treesitter.get_parser() may return nil
-- instead of throwing an error when no parser is available (behavior change
-- around build 2582). Some plugins (rainbow-delimiters, nvim-treesitter-context,
-- none-ls todo_comments builtins) don't handle nil and crash.
-- Returns a stub parser with safe method return values for Neovim v0.12+ and later only.
-- TODO: Remove once plugins add nil checks upstream.
if vim.treesitter and vim.treesitter.get_parser and not vim.g._ts_get_parser_patched then
  -- Only apply stub on v0.12+ where get_parser returns nil instead of throwing
  local v = vim.version()
  if v.major > 0 or (v.major == 0 and v.minor >= 12) then
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
        -- Resolve lang from buffer filetype if not passed explicitly
        local resolved_lang = lang
        if not resolved_lang and bufnr then
          local ft = vim.bo[bufnr] and vim.bo[bufnr].ft
          if ft then
            resolved_lang = vim.treesitter.language.get_lang(ft) or ft
          end
        end
        return setmetatable({ _lang = resolved_lang, _bufnr = bufnr }, noop_parser_mt)
      end
      -- v0.12-dev <2582 still throws; re-throw at level 2 so traceback
      -- points to the caller, not this wrapper
      error(parser, 2)
    end
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
