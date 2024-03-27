return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTRun",
      "ChatGPTEditWithInstructions",
      "ChatGPTCompleteCode",
    },
    opts = {
      openai_params = {
        model = "gpt-4",
      },
      openai_edit_params = {
        model = "gpt-4",
      },
    },
  },

  {
    "David-Kunz/gen.nvim",
    opts = {
      display_mode = "split",
    },
    cmd = { "Gen" },
  },

  {
    "Exafunction/codeium.nvim",
    opts = {
      enable_chat = true,
    },
  },
}
