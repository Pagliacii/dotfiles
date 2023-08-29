local mappings = {
  i = {
    ["<M-p>"] = function(...)
      return require("telescope.actions.layout").toggle_preview(...)
    end,
  },
  n = {
    ["j"] = function(...)
      return require("telescope.actions").move_selection_next(...)
    end,
    ["k"] = function(...)
      return require("telescope.actions").move_selection_previous(...)
    end,
    ["gg"] = function(...)
      return require("telescope.actions").move_to_top(...)
    end,
    ["G"] = function(...)
      return require("telescope.actions").move_to_bottom(...)
    end,
    ["<M-p>"] = function(...)
      return require("telescope.actions.layout").toggle_preview(...)
    end,
  },
}

local pickers = {
  find_files = {
    hidden = true,
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--glob",
      "!**/.git/*",
      "--glob",
      "!**/.hg/*",
      "--ignore-file",
      ".gitignore",
      "--ignore-file",
      ".hgignore",
    },
    mappings = {
      n = {
        ["cd"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          local dir = vim.fn.fnamemodify(selection.path, ":p:h")
          require("telescope.actions").close(prompt_bufnr)
          vim.cmd(string.format("silent tcd %s", dir))
        end,
      },
    },
  },
}

local dependencies = {
  {
    "nvim-telescope/telescope-dap.nvim",
    keys = {
      { "<leader>d1", "<cmd> Telescope dap commands theme=dropdown<cr>", desc = "Commands" },
      { "<leader>d2", "<cmd> Telescope dap frames<cr>", desc = "Frames" },
      { "<leader>d3", "<cmd> Telescope dap list_breakpoints<cr>", desc = "Breakpoints" },
      { "<leader>d4", "<cmd> Telescope dap configurations theme=dropdown<cr>", desc = "Configurations" },
      { "<leader>d5", "<cmd> Telescope dap variables<cr>", desc = "Variables" },
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    "debugloop/telescope-undo.nvim",
    keys = {
      { "<leader>tu", "<cmd>Telescope undo<cr>", desc = "Undo tree" },
    },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fB",
        "<cmd>Telescope file_browser<cr>",
        desc = "File browser",
        noremap = true,
      },
      {
        "<leader>f.",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "File browser (cwd)",
        noremap = true,
      },
    },
  },

  {
    "nvim-telescope/telescope-project.nvim",
    keys = {
      { "<leader>tp", "<cmd>Telescope project theme=dropdown<cr>", desc = "Projects", noremap = true },
    },
  },

  {
    "benfowler/telescope-luasnip.nvim",
    keys = {
      { "<leader>tS", "<cmd>Telescope luasnip theme=ivy<cr>", desc = "Snippets", noremap = true },
    },
  },

  {
    "LinArcX/telescope-env.nvim",
    keys = {
      { "<leader>tv", "<cmd>Telescope env<cr>", desc = "Env variables", noremap = true },
    },
  },

  {
    "LinArcX/telescope-command-palette.nvim",
    keys = {
      { "<leader>tC", "<cmd>Telescope command_palette<cr>", desc = "Command palette", noremap = true },
    },
  },

  {
    "LinArcX/telescope-scriptnames.nvim",
    keys = {
      { "<leader>tA", "<cmd>Telescope scriptnames<cr>", desc = "Scriptnames", noremap = true },
    },
  },

  {
    "LinArcX/telescope-changes.nvim",
    keys = {
      { "<leader>tc", "<cmd>Telescope changes<cr>", desc = "Changes", noremap = true },
    },
  },

  {
    "AckslD/nvim-neoclip.lua",
    config = true,
    keys = {
      { "<leader>ty", "<cmd>Telescope neoclip theme=dropdown<cr>", desc = "Yanks", noremap = true },
    },
  },

  {
    "crispgm/telescope-heading.nvim",
    keys = {
      { "<leader>th", "<cmd>Telescope heading theme=dropdown<cr>", desc = "Headings", noremap = true },
    },
  },

  {
    "LukasPietzschmann/telescope-tabs",
    opts = {
      show_preview = false,
    },
    keys = {
      { "<leader>tT", "<cmd>Telescope telescope-tabs list_tabs theme=dropdown<cr>", desc = "Tabs", noremap = true },
    },
  },

  {
    "xiyaowong/telescope-emoji.nvim",
    keys = {
      { "<leader>te", "<cmd>Telescope emoji theme=ivy<cr>", desc = "Emoji", noremap = true },
    },
  },

  {
    "ghassan0/telescope-glyph.nvim",
    keys = {
      { "<leader>tG", "<cmd>Telescope glyph theme=dropdown<cr>", desc = "Glyph", noremap = true },
    },
  },

  { "aaronhallaert/advanced-git-search.nvim" },

  {
    "nvim-telescope/telescope-symbols.nvim",
    keys = {
      { "<leader>ts", "<cmd>Telescope symbols theme=dropdown<cr>", desc = "Symbols", noremap = true },
    },
  },

  {
    "olimorris/persisted.nvim",
    opts = {
      should_autosave = function()
        -- do not autosave if the alpha dashboard is the current filetype
        return vim.bo.filetype ~= "alpha"
      end,
      use_git_branch = true,
    },
    keys = {
      { "<leader>tP", "<cmd>Telescope persisted theme=dropdown<cr>", desc = "Sessions", noremap = true },
    },
  },

  {
    "Marskey/telescope-sg",
    keys = {
      { "<leader>ta", "<cmd>Telescope ast_grep<cr>", desc = "AST grep", noremap = true },
    },
  },
}

local extensions = {
  file_browser = {
    hidden = {
      file_browser = true,
      folder_browser = true,
    },
    theme = "dropdown",
    hijack_netrw = true,
  },
  heading = {
    treesitter = true,
  },
  luasnip = {
    theme = "dropdown",
  },
  project = {
    hidden_files = true,
    sync_with_nvim_tree = true,
    on_project_selected = function(prompt_bufnr)
      require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
    end,
  },
  undo = {
    use_delta = true,
    side_by_side = true,
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 0.2,
      preview_height = 0.4,
    },
    height = 0.9,
    width = 0.9,
  },
  advanced_git_search = {
    diff_plugin = "diffview",
    show_builtin_git_pickers = false,
  },
  command_palette = {
    {
      "CommentBox",
      { "Left aligned box of fixed size with Left aligned text", [[:lua require("comment-box").llbox()]] },
      { "Left aligned box of fixed size with Centered text", [[:lua require("comment-box").lcbox()]] },
      { "Left aligned box of fixed size with Right aligned text", [[:lua require("comment-box").lrbox()]] },
      { "Centered box of fixed size with Left aligned text", [[:lua require("comment-box").clbox()]] },
      { "Centered box of fixed size with Centered text", [[:lua require("comment-box").ccbox()]] },
      { "Centered box of fixed size with Right aligned text", [[:lua require("comment-box").crbox()]] },
      { "Right aligned box of fixed size with Left aligned text", [[:lua require("comment-box").rlbox()]] },
      { "Right aligned box of fixed size with Centered text", [[:lua require("comment-box").rcbox()]] },
      { "Right aligned box of fixed size with Right aligned text", [[:lua require("comment-box").rrbox()]] },
      { "Left aligned adapted box", [[:lua require("comment-box").albox()]] },
      { "Centered adapted box", [[:lua require("comment-box").acbox()]] },
      { "Right aligned adapted box", [[:lua require("comment-box").arbox()]] },
      { "Left aligned line", [[:lua require("comment-box").line()]] },
      { "Centered line", [[:lua require("comment-box").cline()]] },
      { "Right aligned line", [[:lua require("comment-box").rline()]] },
    },
  },
  ast_grep = {
    command = {
      "sg",
      "--json=stream",
      "-p",
    }, -- must have --json and -p
    grep_open_files = false, -- search in opened files
    lang = nil, -- string value, specify language for ast-grep `nil` for default
  },
}

local config = function(_, opts)
  local telescope = require("telescope")
  telescope.setup(opts)
  telescope.load_extension("dap")
  telescope.load_extension("fzf")
  telescope.load_extension("undo")
  telescope.load_extension("file_browser")
  telescope.load_extension("project")
  telescope.load_extension("luasnip")
  telescope.load_extension("env")
  telescope.load_extension("command_palette")
  telescope.load_extension("neoclip")
  telescope.load_extension("heading")
  telescope.load_extension("scriptnames")
  telescope.load_extension("changes")
  telescope.load_extension("emoji")
  telescope.load_extension("glyph")
  telescope.load_extension("notify")
  telescope.load_extension("harpoon")
  telescope.load_extension("advanced_git_search")
  telescope.load_extension("persisted")
  telescope.load_extension("ast_grep")
end

local buffer_previewer_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local opts = {
  defaults = {
    previewer = false,
    mappings = mappings,
    buffer_previewer_maker = buffer_previewer_maker,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-C=0",
      "--hidden",
      "--glob",
      "!**/.git/*",
      "--glob",
      "!**/.hg/*",
      "--ignore-file",
      ".gitignore",
      "--ignore-file",
      ".hgignore",
    },
  },
  pickers = pickers,
  extensions = extensions,
}

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = dependencies,
    opts = opts,
    config = config,
    keys = {
      { "<leader>tM", "<cmd>Telescope man_pages<cr>", desc = "Man pages", noremap = true },
      { "<leader>tn", "<cmd>Telescope notify theme=ivy<cr>", desc = "Notify", noremap = true },
      { "<leader>tt", "<cmd>Telescope treesitter<cr>", desc = "Treesitter", noremap = true },
      { "<leader>tj", "<cmd>Telescope jumplist theme=dropdown<cr>", desc = "Jump list", noremap = true },
      { "<leader>tl", "<cmd>Telescope loclist<cr>", desc = "Location list", noremap = true },
      { "<leader>tR", "<cmd>Telescope registers theme=dropdown<cr>", desc = "Registers", noremap = true },
      { "<leader>tx", "<cmd>Telescope quickfix<cr>", desc = "Quickfix", noremap = true },
      { "<leader>tr", "<cmd>Telescope resume<cr>", desc = "Resume", noremap = true },
    },
  },
}
