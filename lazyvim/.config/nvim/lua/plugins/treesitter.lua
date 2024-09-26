return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
    },
    opts = {
      indent = { enable = false },
      ensure_installed = {
        "bash",
        "dap_repl",
        "json",
        "html", -- for devdocs
        "http", -- for rest.nvim
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "org",
        "python",
        "query",
        "regex",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        -- `true` to always enalbe or a a list of parsers
        additional_vim_regex_highlighting = true,
        disable = function(_, bufnr)
          local line_nr_thresh = 5000
          return vim.api.nvim_buf_line_count(bufnr) > line_nr_thresh
        end,
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      endwise = { enable = true },
    },
  },

  {
    "Wansmer/treesj",
    opts = {
      ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
      use_default_keymaps = false,
      ---@type number If line after join will be longer than max value, node will not be formatted
      max_join_length = 120,
      cursor_behavior = "end",
    },
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join toggle" },
    },
  },

  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },

  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    config = true,
  },

  {
    "haringsrob/nvim_context_vt",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      disable_ft = { "markdown", "lazy" },
    },
  },

  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function(_, opts)
      require("sibling-swap").setup(opts)
    end,
    opts = {
      use_default_keymaps = false,
      allowed_separators = { "..", "*" }, -- add multiplication & lua string concatenation
      highlight_node_at_cursor = true,
      ignore_injected_langs = true,
      allow_interline_swaps = true,
      interline_swaps_without_separator = false,
    },
    keys = {
      {
        "<leader>cw",
        function()
          require("sibling-swap").swap_with_right()
        end,
        desc = "Swap with right",
      },
      {
        "<leader>cW",
        function()
          require("sibling-swap").swap_with_left()
        end,
        desc = "Swap with left",
      },
    },
  },
}
