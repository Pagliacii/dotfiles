return {
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      vim.g.baleia = require("baleia").setup({})
      vim.g.conjure_baleia = require("baleia").setup({ line_starts_at = 3 })

      -- Command to colorize the current buffer
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        vim.g.baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      -- Command to show logs
      vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })

      -- Automatically colorize when lines are added to the buffer
      vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        pattern = "*.txt",
        callback = function()
          vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
        end,
      })

      -- Automatically colorize text added to the quickfix window
      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        pattern = "quickfix",
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })
          vim.g.baleia.automatically(buffer)
          vim.api.nvim_set_option_value("modified", false, { buf = buffer })
          vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })
        end,
      })
    end,
    cmd = { "BaleiaColorize", "BaleiaLogs" },
  },

  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "lua", "racket", "scheme" },
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
      vim.g["conjure#extract#tree_sitter#enabled"] = true
      -- Rebind it from K to <prefix>gk
      vim.g["conjure#mapping#doc_word"] = "gk"

      -- Print color codes if baleia.nvim is available
      local colorize = require("lazyvim.util").has("baleia.nvim")
      vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = colorize and 1 or nil

      -- Disable diagnostics in log buffer and colorize it
      vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        pattern = "conjure-log-*",
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          vim.diagnostic.enable(false, { bufnr = buffer })
          if colorize and vim.g.conjure_baleia then
            vim.g.conjure_baleia.automatically(buffer)
          end
        end,
      })
    end,
    config = function()
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  },
}
