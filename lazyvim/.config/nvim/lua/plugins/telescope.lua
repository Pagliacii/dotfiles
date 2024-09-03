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
  colorscheme = {
    enable_preview = true,
  },
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
  helpgrep = {
    ignore_paths = {
      vim.fn.stdpath("state") .. "/lazy/readme",
    },
    mappings = {
      i = {
        ["<CR>"] = require("telescope.actions").select_default,
        ["<C-v>"] = require("telescope.actions").select_vertical,
      },
      n = {
        ["<CR>"] = require("telescope.actions").select_default,
        ["<C-s>"] = require("telescope.actions").select_horizontal,
      },
    },
    default_grep = require("telescope.builtin").live_grep,
  },
  import = {
    insert_at_top = true,
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

local buffer_previewer_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 1000000 then
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

local dependencies = {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}

local keys = {
  { "<leader>fb", false },
  { "<leader>sb", false },
  { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)", noremap = true },
  { "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", noremap = true },
  { "<leader>tM", "<cmd>Telescope man_pages<cr>", desc = "Man pages", noremap = true },
  { "<leader>tn", "<cmd>Telescope notify theme=ivy<cr>", desc = "Notify", noremap = true },
  { "<leader>tt", "<cmd>Telescope treesitter<cr>", desc = "Treesitter", noremap = true },
  { "<leader>tj", "<cmd>Telescope jumplist theme=dropdown<cr>", desc = "Jump list", noremap = true },
  { "<leader>tl", "<cmd>Telescope loclist<cr>", desc = "Location list", noremap = true },
  { "<leader>tR", "<cmd>Telescope registers theme=dropdown<cr>", desc = "Registers", noremap = true },
  { "<leader>tx", "<cmd>Telescope quickfix<cr>", desc = "Quickfix", noremap = true },
  { "<leader>tr", "<cmd>Telescope resume<cr>", desc = "Resume", noremap = true },
  { "<leader>tC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", noremap = true },
  {
    "<leader>/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    desc = "Fuzzy search (buffer)",
    noremap = true,
  },
}

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = dependencies,
    opts = opts,
    keys = keys,
  },
  {
    "catgoose/telescope-helpgrep.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>tH", "<cmd>Telescope helpgrep<cr>", desc = "Helpgrep", noremap = true },
    },
  },
}
