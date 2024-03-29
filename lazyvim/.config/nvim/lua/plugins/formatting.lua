return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt", "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        -- Conform will run multiple formatters sequentially
        markdown = { "markdown-toc", "prettierd" },
        go = { "gofumpt", "goimports_reviser", "golines" },
        python = { "ruff_fix", "ruff_format" },
        rust = { "rustfmt" },
        toml = { "taplo" },
        json = { "jq" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cmake = { "cmake_format" },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, table>
      formatters = {
        -- -- Example of using options only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        goimports_reviser = function()
          return {
            -- This can be a string or a function that returns a string
            command = "goimports-reviser",
            -- OPTIONAL - all fields below this are optional
            -- A list of strings, or a function that returns a list of strings
            -- Return a single string instead to run the command in a shell
            args = { "-rm-unused", "$FILENAME" },
            -- A function that calculates the directory to run the command in
            cwd = require("conform.util").root_file({ ".git", "go.work", "go.mod" }),
            -- When cwd is not found, don't run the formatter (default false)
            require_cwd = true,
          }
        end,
        ruff_format = {
          "--select",
          table.concat({
            "A", -- flake8-builtins
            "ANN", -- flake8-annotations
            "ARG", -- flake8-unused-arguments
            "B", -- flake8-bugbear
            "COM", -- flake8-commas
            "C4", -- flake8-comprehensions
            "FA", -- flake8-future-annotations
            "RET", -- flake8-return
            "SLF", -- flake8-self
            "E", -- pycodestyle error
            "F", -- pyflakes
            "I", -- isort
            "N", -- pep8-naming
            "W", -- pycodestyle warning
          }, ","),
          "--unfixable",
          table.concat({
            "ANN204", -- missing-return-type-special-method
          }, ","),
        },
      },
    },
  },
}
