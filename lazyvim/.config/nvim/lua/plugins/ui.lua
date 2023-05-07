return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "compact",
    },
  },

  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
    config = {
      excluded_filetypes = { "alpha", "neo-tree" },
      current_only = true,
      winblend = 75,
    },
  },

  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      local logo = [[
██████╗  █████╗  ██████╗ ██╗     ██╗ █████╗  ██████╗██╗██╗
██╔══██╗██╔══██╗██╔════╝ ██║     ██║██╔══██╗██╔════╝██║██║
██████╔╝███████║██║  ███╗██║     ██║███████║██║     ██║██║
██╔═══╝ ██╔══██║██║   ██║██║     ██║██╔══██║██║     ██║██║
██║     ██║  ██║╚██████╔╝███████╗██║██║  ██║╚██████╗██║██║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝╚═╝
                  [ github.com/Pagliacii ]
      ]]
      dashboard.section.header.val = vim.split(logo, "\n", {})
      dashboard.config.opts.setup = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          desc = "disable tabline for alpha",
          callback = function()
            vim.opt.showtabline = 0
          end,
        })
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          desc = "enable tabline after alpha",
          callback = function()
            vim.opt.showtabline = 2
          end,
        })
      end
    end,
  },
}
