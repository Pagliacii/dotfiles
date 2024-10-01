local filetypes = { "markdown" }
local leader_key = "<leader>m"

local function get_file_path()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    return file_path
  end

  -- Get the content of the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")

  -- Create a temporary file to store the content
  local tmp_file = os.tmpname()
  local file = io.open(tmp_file, "w")
  file:write(content)
  file:close()
  return tmp_file
end

vim.keymap.set("n", leader_key .. "m", function()
  if vim.fn.executable("markmap") ~= 1 then
    vim.notify("Markmap not found", vim.log.levels.ERROR)
  end

  local cmd = vim.fn.exepath("markmap")
  local file_path = get_file_path()
  -- Create a temporary file to store the HTML content
  local tmp_file = vim.fn.tempname() .. ".html"
  vim.system({ cmd, "--offline", "--output", tmp_file, file_path }, { text = true })
end, { desc = "Markmap", silent = true, noremap = true })

vim.keymap.set("n", leader_key .. "s", function()
  if vim.fn.executable("slides") ~= 1 then
    vim.notify("Slides not found", vim.log.levels.ERROR)
  end

  local cmd = vim.fn.exepath("slides")
  local file_path = get_file_path()
  -- Run the command
  LazyVim.terminal.open({ cmd, file_path }, {
    esc_esc = false,
    ctrl_hjkl = false,
    ft = "slides",
    size = {
      width = vim.api.nvim_get_option("columns"),
      height = vim.api.nvim_get_option("lines"),
    },
  })
end, { desc = "Slides", silent = true, noremap = true })

return {
  {
    "ellisonleao/glow.nvim",
    enabled = vim.fn.executable("glow") == 1,
    config = true,
    cmd = { "Glow" },
    keys = {
      { leader_key .. "g", "<cmd>Glow<cr>", desc = "Preview in glow", silent = true },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = function()
      return {
        {
          leader_key .. "b",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Preview in browser",
          silent = true,
        },
      }
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.hover.dictionary,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "glow",
        "markdown-toc",
        "markmap-cli",
        "prettierd",
        "write-good",
      })
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    ft = filetypes,
    event = "BufReadPre",
    opts = {},
    keys = {
      { leader_key .. "p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image", noremap = true },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = false,
        icons = { "◉ ", "○ ", "◆ ", "◇ ", "★ ", "✸ " },
      },
      code = {
        sign = false,
        left_pad = 2,
        right_pad = 2,
        width = "block",
      },
    },
  },
}
