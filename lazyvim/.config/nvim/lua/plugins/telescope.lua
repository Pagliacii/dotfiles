local mappings = {
  i = {
    ["<C-j>"] = function(...)
      return require("telescope.actions").move_selection_next(...)
    end,
    ["<C-k>"] = function(...)
      return require("telescope.actions").move_selection_previous(...)
    end,
    ["<C-p>"] = function(...)
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
    ["<C-p>"] = function(...)
      return require("telescope.actions.layout").toggle_preview(...)
    end,
  },
}

local pickers = {
  find_files = {
    previewer = false,
  },
  git_files = {
    previewer = false,
  },
  oldfiles = {
    previewer = false,
  },
}

local dependencies = {
  {
    "nvim-telescope/telescope-dap.nvim",
    keys = {
      { "<leader>d1", "<cmd> Telescope dap commands<cr>", desc = "Commands" },
      { "<leader>d2", "<cmd> Telescope dap frames<cr>", desc = "Frames" },
      { "<leader>d3", "<cmd> Telescope dap list_breakpoints<cr>", desc = "Breakpoints" },
      { "<leader>d4", "<cmd> Telescope dap configurations<cr>", desc = "Configurations" },
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
      { "<leader>fu", "<cmd> Telescope undo<cr>", desc = "Undo tree" },
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
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects", noremap = true },
    },
  },

  {
    "benfowler/telescope-luasnip.nvim",
    keys = {
      { "<leader>fS", "<cmd>Telescope luasnip<cr>", desc = "Snippets", noremap = true },
    },
  },

  {
    "LinArcX/telescope-env.nvim",
    keys = {
      { "<leader>fv", "<cmd>Telescope env<cr>", desc = "Env variables", noremap = true },
    },
  },

  {
    "LinArcX/telescope-command-palette.nvim",
    keys = {
      { "<leader>C", "<cmd>Telescope command_palette<cr>", desc = "Command palette", noremap = true },
    },
  },

  {
    "LinArcX/telescope-scriptnames.nvim",
    keys = {
      { "<leader>fs", "<cmd>Telescope scriptnames<cr>", desc = "Scriptnames", noremap = true },
    },
  },

  {
    "LinArcX/telescope-changes.nvim",
    keys = {
      { "<leader>fc", "<cmd>Telescope changes<cr>", desc = "Changes", noremap = true },
    },
  },

  {
    "AckslD/nvim-neoclip.lua",
    config = true,
    keys = {
      { "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "Yanks", noremap = true },
    },
  },

  {
    "crispgm/telescope-heading.nvim",
    keys = {
      { "<leader>fh", "<cmd>Telescope heading<cr>", desc = "Headings", noremap = true },
    },
  },

  {
    "LukasPietzschmann/telescope-tabs",
    config = true,
    opts = {
      show_preview = false,
    },
    keys = {
      { "<leader>fl", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Tabs", noremap = true },
    },
  },

  {
    "xiyaowong/telescope-emoji.nvim",
    keys = {
      { "<leader>fj", "<cmd>Telescope emoji<cr>", desc = "Emoji", noremap = true },
    },
  },

  {
    "ghassan0/telescope-glyph.nvim",
    keys = {
      { "<leader>fg", "<cmd>Telescope glyph<cr>", desc = "Glyph", noremap = true },
    },
  },
}

local extensions = {
  file_browser = {
    previewer = false,
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
    previewer = false,
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
    find_files = {
      hidden = true,
    },
    mappings = mappings,
    buffer_previewer_maker = buffer_previewer_maker,
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
      { "<leader>fN", "<cmd>Telescope notify<cr>", desc = "Notify", noremap = true },
    },
  },
}
