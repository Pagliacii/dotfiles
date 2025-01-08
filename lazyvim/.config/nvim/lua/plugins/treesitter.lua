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
        "fennel",
        "json",
        "html", -- for devdocs
        "http", -- for rest.nvim
        "latex",
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
    "aaronik/treewalker.nvim",
    cmd = "Treewalker",
    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",
    },
    keys = {
      { "<leader>Tk", "<cmd>Treewalker Up<cr>", mode = { "n", "v" }, desc = "move up to neighbor node", silent = true },
      {
        "<leader>Tj",
        "<cmd>Treewalker Down<cr>",
        mode = { "n", "v" },
        desc = "move down to neighbor node",
        silent = true,
      },
      { "<leader>Tl", "<cmd>Treewalker Right<cr>", mode = { "n", "v" }, desc = "move up to next node", silent = true },
      {
        "<leader>Th",
        "<cmd>Treewalker Left<cr>",
        mode = { "n", "v" },
        desc = "move up to ancestor node",
        silent = true,
      },
      { "<leader>TK", "<cmd>Treewalker SwapUp<cr>", desc = "swap nodes up", silent = true },
      { "<leader>TJ", "<cmd>Treewalker SwapDown<cr>", desc = "swap nodes down", silent = true },
      { "<leader>TL", "<cmd>Treewalker SwapRight<cr>", desc = "swap nodes right", silent = true },
      { "<leader>TH", "<cmd>Treewalker SwapLeft<cr>", desc = "swap nodes left", silent = true },
    },
  },
}
