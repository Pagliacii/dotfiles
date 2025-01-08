return {
  {
    "willothy/wezterm.nvim",
    config = true,
    cmd = { "WeztermSpawn" },
    keys = {
      {
        "<leader>Wp",
        function()
          require("wezterm").switch_tab.relative(-1)
        end,
        desc = "Prev tab",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wn",
        function()
          require("wezterm").switch_tab.relative(1)
        end,
        desc = "Next tab",
        silent = true,
        noremap = true,
      },
      {
        "<leader>W-",
        function()
          require("wezterm").split_pane.vertical()
        end,
        desc = "Split pane below",
        silent = true,
        noremap = true,
      },
      {
        "<leader>W|",
        function()
          require("wezterm").split_pane.horizontal()
        end,
        desc = "Split pane right",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wj",
        function()
          require("wezterm").switch_pane.direction("Down")
        end,
        desc = "Switch to down pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wk",
        function()
          require("wezterm").switch_pane.direction("Up")
        end,
        desc = "Switch to up pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wh",
        function()
          require("wezterm").switch_pane.direction("Left")
        end,
        desc = "Switch to left pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wl",
        function()
          require("wezterm").switch_pane.direction("Right")
        end,
        desc = "Switch to right pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>WP",
        function()
          require("wezterm").switch_pane.direction("Prev")
        end,
        desc = "Switch to previous pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>WN",
        function()
          require("wezterm").switch_pane.direction("Next")
        end,
        desc = "Switch to next pane",
        silent = true,
        noremap = true,
      },
    },
  },

  {
    "willothy/flatten.nvim",
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = "alternate",
        },
        hooks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)

              -- If we're in a different wezterm pane/tab, switch to the current one
              -- Requires willothy/wezterm.nvim
              require("wezterm").switch_pane.id(tonumber(os.getenv("WEZTERM_PANE")))
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
  },
}
