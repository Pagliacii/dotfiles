local prefix = "<leader>j"

return {
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = vim.uv.os_homedir() .. "/snippets",
      jsonFormatter = "jq",
    },
    keys = {
      {
        prefix .. "a",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "n", "v" },
        desc = "Add new snippet",
        noremap = true,
        silent = true,
      },
      {
        prefix .. "e",
        function()
          require("scissors").editSnippet()
        end,
        desc = "Edit snippets",
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "Sanix-Darker/snips.nvim",
    cmd = {
      "SnipsCreate",
      "SnipsCreateFromRegister",
      "SnipsList",
    },
    opts = {
      post_behavior = "echo_and_yank",
      ssh_cmd = "ssh -T",
    },
    keys = {
      { prefix .. "C", ":SnipsCreate<cr>", mode = { "v" }, desc = "Share selected code", silent = true },
      { prefix .. "l", ":SnipsList<cr>", desc = "List snips", silent = true },
    },
  },

  {
    "michaelrommel/nvim-silicon",
    enabled = vim.fn.executable("silicon") == 1,
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    opts = {
      font = "JetBrainsMono Nerd Font",
      theme = "Catppuccin Macchiato",
      pad_horiz = 40,
      pad_vert = 20,
      line_offset = function(args)
        return args.line1
      end,
      shadow_color = "#100808",
      num_separator = "▏ ",
      to_clipboard = true,
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
      end,
    },
    keys = {
      {
        prefix .. "c",
        function()
          require("nvim-silicon").clip()
        end,
        mode = "v",
        desc = "Copy code screenshot to clipboard",
      },
      {
        prefix .. "f",
        function()
          require("nvim-silicon").file()
        end,
        mode = "v",
        desc = "Save code screenshot as file",
      },
      {
        prefix .. "s",
        function()
          require("nvim-silicon").shoot()
        end,
        mode = "v",
        desc = "Create code screenshot",
      },
    },
  },
}
