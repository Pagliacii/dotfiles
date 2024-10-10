local function quicknote_cmd(name)
  return string.format("<cmd>lua require('quicknote').%s()<cr>", name)
end

local function toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<cr>", { noremap = true, silent = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<cr>", { noremap = true, silent = true })
    require("indent_blankline.commands").disable()
  else
    vim.cmd([[setlocal ve=]])
    vim.cmd([[mapclear <buffer>]])
    vim.b.venn_enabled = nil
    require("indent_blankline.commands").enable()
  end
end

local prefix = "<leader>n"
local neorg_prefix = prefix .. "o"
local qn_prefix = prefix .. "q"
local zt_prefix = prefix .. "z"
local ob_prefix = prefix .. "b"

return {
  {
    "RutaTang/quicknote.nvim",
    config = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { qn_prefix .. "lc", quicknote_cmd("NewNoteAtCurrentLine"), desc = "Create" },
      { qn_prefix .. "lo", quicknote_cmd("OpenNoteAtCurrentLine"), desc = "Open" },
      { qn_prefix .. "ld", quicknote_cmd("DeleteNoteAtCurrentLine"), desc = "Delete" },
      { qn_prefix .. "wc", quicknote_cmd("NewNoteAtCWD"), desc = "Create" },
      { qn_prefix .. "wo", quicknote_cmd("OpenNoteAtCWD"), desc = "Open" },
      { qn_prefix .. "wd", quicknote_cmd("DeleteNoteAtCWD"), desc = "Delete" },
      { qn_prefix .. "gc", quicknote_cmd("NewNoteAtGlobal"), desc = "Create" },
      { qn_prefix .. "go", quicknote_cmd("OpenNoteAtGlobal"), desc = "Open" },
      { qn_prefix .. "gd", quicknote_cmd("DeleteNoteAtGlobal"), desc = "Delete" },
      { qn_prefix .. "Lb", quicknote_cmd("ListNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "Lc", quicknote_cmd("ListNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "Lg", quicknote_cmd("ListNotesForGlobal"), desc = "Global" },
      { qn_prefix .. "Lf", quicknote_cmd("ListNotesForAFileOrWDInCWD"), desc = "File or dir" },
      { qn_prefix .. "jp", quicknote_cmd("JumpToPreviousNote"), desc = "Previous" },
      { qn_prefix .. "jn", quicknote_cmd("JumpToNextNote"), desc = "Next" },
      { qn_prefix .. "cb", quicknote_cmd("GetNotesCountForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "cc", quicknote_cmd("GetNotesCountForCWD"), desc = "CWD" },
      { qn_prefix .. "cg", quicknote_cmd("GetNotesCountForGlobal"), desc = "Global" },
      { qn_prefix .. "s", quicknote_cmd("ToggleNoteSigns"), desc = "Toggle signs" },
      { qn_prefix .. "eb", quicknote_cmd("ExportNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "ec", quicknote_cmd("ExportNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "eg", quicknote_cmd("ExportNotesForGlobal"), desc = "Global" },
      { qn_prefix .. "ib", quicknote_cmd("ImportNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "ic", quicknote_cmd("ImportNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "ig", quicknote_cmd("ImportNotesForGlobal"), desc = "Global" },
    },
  },

  {
    "jbyuki/venn.nvim",
    cmd = { "VBox" },
    keys = {
      { prefix .. "v", toggle_venn, desc = "Venn", noremap = true },
    },
  },

  {
    "backdround/global-note.nvim",
    cmd = { "GlobalNote" },
    config = true,
    keys = {
      {
        prefix .. "g",
        function()
          require("global-note").toggle_note()
        end,
        desc = "Global Note",
        noremap = true,
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = { "typ", "typst" },
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      { prefix .. "tp", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview", noremap = true },
      { prefix .. "tc", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Sync Cursor", noremap = true },
      { prefix .. "ts", "<cmd>TypstPreview slide<cr>", desc = "Preview in slides", noremap = true },
    },
  },

  {
    "williamboman/mason.nvim",
    ft = { "typ", "typst" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typstfmt",
        "typst-lsp",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "typ", "typst" },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.typstfmt,
      })
    end,
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
      },
      { "bottd/neorg-worklog" },
      { "nvim-neorg/neorg-telescope" },
      { "juniorsundar/neorg-extras" },
    },
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.completion"] = {
            config = { engine = "nvim-cmp", name = "[Norg] " },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.concealer"] = { config = { icon_preset = "diamond" } },
          ["core.keybinds"] = {
            -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/module.lua
            config = {
              default_keybinds = true,
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = { config = { extensions = "all" } },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
          ["core.summary"] = {},
          ["core.ui.calendar"] = {},
          ["core.looking-glass"] = {},
          ["core.clipboard.code-blocks"] = {},
          ["core.esupports.hop"] = {},
          ["core.esupports.indent"] = {},
          ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
          ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
          ["core.tangle"] = { config = { report_on_empty = false } },
          ["core.journal"] = { config = { strategy = "flat" } },
          ["core.integrations.telescope"] = {},
          ["core.pivot"] = {},
          ["core.promo"] = {},

          ["external.agenda"] = {},
          ["external.roam"] = {},
          ["external.worklog"] = {},
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
    keys = {
      { prefix .. "n", "<cmd>tabnew | Neorg index<cr>", desc = "Neorg Index" },
      { prefix .. "d", "<cmd>tabnew | Neorg journal today<cr>", desc = "Today Journal" },
      {
        prefix .. "k",
        function()
          local dirman = require("neorg").modules.get_module("core.dirman")
          dirman.create_file("tasks", "notes", {
            no_open = false, -- open file after creation?
            force = false, -- overwrite file if exists
            metadata = {}, -- key-value table for metadata fields
          })
        end,
        desc = "Neorg task",
      },
      { neorg_prefix .. "r", "<cmd>Neorg return<cr>", desc = "Return" },
      { neorg_prefix .. "a", "<cmd>Neorg agenda<cr>", desc = "Agenda" },
      { neorg_prefix .. "r", "<cmd>Neorg roam<cr>", desc = "Roam" },
      { neorg_prefix .. "t", "<cmd>Neorg cycle_task<cr>", desc = "Cycle task" },
    },
  },

  {
    "nvim-orgmode/orgmode",
    event = "BufRead",
    ft = { "org" },
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
  },

  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-telekasten/calendar-vim",
    },
    cmd = { "Telekasten" },
    opts = {
      home = vim.fn.expand("~/zettelkasten"),
    },
    keys = {
      { "<localleader>z", "<cmd>Telekasten panel<cr>", desc = "Panel", noremap = true },
      { zt_prefix .. "p", "<cmd>Telekasten panel<cr>", desc = "Panel", noremap = true },
      { zt_prefix .. "f", "<cmd>Telekasten find_notes<cr>", desc = "Find notes", noremap = true },
      { zt_prefix .. "F", "<cmd>Telekasten find_friends<cr>", desc = "Find friends", noremap = true },
      { zt_prefix .. "g", "<cmd>Telekasten search_notes<cr>", desc = "Search notes", noremap = true },
      { zt_prefix .. "d", "<cmd>Telekasten goto_today<cr>", desc = "Daily notes", noremap = true },
      { zt_prefix .. "D", "<cmd>Telekasten find_daily_notes<cr>", desc = "Find daily notes", noremap = true },
      { zt_prefix .. "w", "<cmd>Telekasten goto_thisweek<cr>", desc = "Weekly notes", noremap = true },
      { zt_prefix .. "W", "<cmd>Telekasten find_weekly_notes<cr>", desc = "Find weekly notes", noremap = true },
      { zt_prefix .. "z", "<cmd>Telekasten follow_link<cr>", desc = "Follow link", noremap = true },
      { zt_prefix .. "n", "<cmd>Telekasten new_note<cr>", desc = "New note", noremap = true },
      { zt_prefix .. "N", "<cmd>Telekasten new_templated_note<cr>", desc = "New note by template", noremap = true },
      { zt_prefix .. "c", "<cmd>Telekasten show_calendar<cr>", desc = "Calendar", noremap = true },
      { zt_prefix .. "b", "<cmd>Telekasten show_backlinks<cr>", desc = "Backlinks", noremap = true },
      { zt_prefix .. "t", "<cmd>Telekasten toggle_todo<cr>", desc = "Toggle todo", noremap = true },
      { zt_prefix .. "T", "<cmd>Telekasten show_tags<cr>", desc = "Tags", noremap = true },
      { zt_prefix .. "I", "<cmd>Telekasten insert_img_link<cr>", desc = "Insert image link", noremap = true },
      { "[[", "<cmd>Telekasten insert_link<cr>", mode = "i", desc = "Insert image link", noremap = true },
      { zt_prefix .. "p", "<cmd>Telekasten paste_img_and_link<cr>", desc = "Paste image and link", noremap = true },
      -- { zt_prefix .. "P", "<cmd>Telekasten preview_img<cr>", desc = "Preview image", noremap = true },
      { zt_prefix .. "y", "<cmd>Telekasten yank_notelink<cr>", desc = "Yank note link", noremap = true },
      -- { zt_prefix .. "B", "<cmd>Telekasten browse_media<cr>", desc = "Browse media files", noremap = true },
      { zt_prefix .. "r", "<cmd>Telekasten rename_note<cr>", desc = "Rename note", noremap = true },
      { zt_prefix .. "v", "<cmd>Telekasten switch_vault<cr>", desc = "Switch vault", noremap = true },
    },
  },

  {
    "JellyApple102/flote.nvim",
    config = true,
    cmd = "Flote",
    keys = {
      { prefix .. "f", "<cmd>Flote<cr>", desc = "Flote", noremap = true },
    },
  },

  {
    "zk-org/zk-nvim",
    enabled = vim.fn.executable("zk") == 1,
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
        picker = "telescope",
      })
    end,
    cmd = { "ZkNew", "ZkNotes" },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter",
      "epwalsh/pomo.nvim",
      "MeanderingProgrammer/render-markdown.nvim", -- for UI
    },
    config = function(_, opts)
      local obsidian = require("obsidian")
      obsidian.setup(opts)
      vim.api.nvim_create_user_command("ObsidianJournal", "ObsidianToday", {})
      vim.api.nvim_create_user_command("ObsidianIndex", function()
        local client = obsidian.get_client()
        local notes = client:find_notes("index.md")
        if #notes == 0 then
          vim.notify("No index note found.", vim.log.levels.ERROR)
        else
          client:open_note(notes[1])
        end
      end, {})
      vim.api.nvim_create_user_command("ObsidianTasks", function()
        local client = obsidian.get_client()
        local notes = client:find_notes("tasks.md")
        if #notes == 0 then
          vim.notify("No tasks note found.", vim.log.levels.ERROR)
        else
          client:open_note(notes[1])
        end
      end, {})
    end,
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes",

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "journals",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%Y-%m-%d",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "journals" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "journal.md",
      },

      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        [ob_prefix .. "c"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Toggle Checkbox" },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^%w-_]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end

        -- Generate Zettelkasten timestamp
        local time = os.date("*t")
        local timestamp = string.format("%04d%02d%02d%02d%02d", time.year, time.month, time.day, time.hour, time.min)
        return timestamp .. "-" .. suffix
      end,

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string, like this:
      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "markdown",

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@param note obsidian.Note
      ---@return table
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        if note:get_field("created") == nil then
          note:add_field("created", os.date("%Y-%m-%d %H:%M:%S"))
        end
        note:add_field("modified", os.date("%Y-%m-%d %H:%M:%S"))

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      -- Optional, for templates (see below).
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        require("sys-open").open(url)
        -- vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        -- vim.ui.open(url) -- need Neovim 0.10.0+
      end,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
      -- file it will be ignored but you can customize this behavior here.
      ---@param img string
      follow_img_func = function(img)
        require("sys-open").open(img)
        -- vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },

      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
      sort_by = "modified",
      sort_reversed = true,

      -- Set the maximum number of lines to read from notes on disk when performing certain searches.
      search_max_lines = 1000,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = "current",

      -- Optional, define your own callbacks to further customize behavior.
      callbacks = {
        -- Runs at the end of `require("obsidian").setup()`.
        ---@param client obsidian.Client
        post_setup = function(client) end,

        -- Runs anytime you enter the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        enter_note = function(client, note) end,

        -- Runs anytime you leave the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        leave_note = function(client, note) end,

        -- Runs right before writing the buffer for a note.
        ---@param client obsidian.Client
        ---@param note obsidian.Note
        pre_write_note = function(client, note) end,

        -- Runs anytime the workspace is set/changed.
        ---@param client obsidian.Client
        ---@param workspace obsidian.Workspace
        post_set_workspace = function(client, workspace) end,
      },

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = false, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets/imgs", -- This is the default

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
        end,

        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
    },
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianTags",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTomorrow",
      "ObsidianDailies",
      "ObsidianTemplate",
      "ObsidianSearch",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianExtractNote",
      "ObsidianWorkspace",
      "ObsidianPasteImg",
      "ObsidianRename",
      "ObsidianToggleCheckbox",
      "ObsidianNewFromTemplate",
      "ObsidianTOC",
      "ObsidianJournal",
      "ObsidianTasks",
      "ObsidianIndex",
    },
    keys = {
      { "<localleader>i", "<cmd>ObsidianIndex<cr>", desc = "Index", noremap = true },
      { "<localleader>t", "<cmd>ObsidianTasks<cr>", desc = "Tasks", noremap = true },
      { "<localleader>j", "<cmd>ObsidianJournal<cr>", desc = "Journal", noremap = true },
      { "<localleader>o", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian", noremap = true },
      { "<localleader>a", "<cmd>ObsidianNew<cr>", desc = "New Note", noremap = true },
      {
        "<localleader>k",
        function()
          local util = require("obsidian.util")
          local viz = util.get_visual_selection()
          vim.ui.input({
            prompt = "Enter a note title: ",
            default = viz.selection,
          }, function(input)
            if input == nil or input == "" then
              return
            end
            vim.cmd("ObsidianLink " .. input)
          end)
        end,
        mode = "v",
        desc = "Link",
        noremap = true,
      },
      {
        "<localleader>K",
        function()
          local util = require("obsidian.util")
          local viz = util.get_visual_selection()
          vim.ui.input({
            prompt = "Enter a note title: ",
            default = viz.selection,
          }, function(input)
            if input == nil or input == "" then
              return
            end
            vim.cmd("ObsidianLinkNew " .. input)
          end)
        end,
        mode = "v",
        desc = "New Link",
        noremap = true,
      },
      { "<localleader>s", "<cmd>ObsidianSearch<cr>", desc = "Search", noremap = true },
      { "<localleader>\\", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", noremap = true },
      { "<localleader>b", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks", noremap = true },
      { "<localleader>c", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle Checkbox", noremap = true },
      { "<localleader>R", "<cmd>ObsidianRename<cr>", desc = "Rename Note", noremap = true },
      { "<localleader>P", "<cmd>ObsidianPasteImg<cr>", desc = "Paste Image", noremap = true },
      { "<localleader>X", "<cmd>ObsidianExtractNote<cr>", mode = { "n", "v" }, desc = "Extract Note", noremap = true },
      { ob_prefix .. "o", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian", noremap = true },
      { ob_prefix .. "d", "<cmd>ObsidianDailies<cr>", desc = "Dailies", noremap = true },
      { ob_prefix .. "w", "<cmd>ObsidianWorkspace<cr>", desc = "Workspace", noremap = true },
      { ob_prefix .. "T", "<cmd>ObsidianTemplate<cr>", desc = "Template", noremap = true },
      { ob_prefix .. "b", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks", noremap = true },
      { ob_prefix .. "l", "<cmd>ObsidianLinks<cr>", desc = "Links", noremap = true },
      { ob_prefix .. "t", "<cmd>ObsidianTags<cr>", desc = "Tags", noremap = true },
      { ob_prefix .. "s", "<cmd>ObsidianSearch<cr>", desc = "Search", noremap = true },
      { ob_prefix .. "n", "<cmd>ObsidianNew<cr>", desc = "New Note", noremap = true },
      { ob_prefix .. "N", "<cmd>ObsidianNewFromTemplate<cr>", desc = "New Note from Template", noremap = true },
      { ob_prefix .. "c", desc = "Toggle Checkbox", noremap = true },
      { ob_prefix .. "p", "<cmd>ObsidianPasteImg<cr>", desc = "Paste Image", noremap = true },
      { ob_prefix .. "e", "<cmd>ObsidianExtractNote<cr>", mode = { "n", "v" }, desc = "Extract Note", noremap = true },
      { ob_prefix .. "C", "<cmd>ObsidianTOC<cr>", desc = "Table of Contents", noremap = true },
      { ob_prefix .. "r", "<cmd>ObsidianRename<cr>", desc = "Rename Note", noremap = true },
      { ob_prefix .. "q", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", noremap = true },
    },
  },
}
