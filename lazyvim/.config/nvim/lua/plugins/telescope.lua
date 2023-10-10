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
  telescope.load_extension("fzf")
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
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
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
