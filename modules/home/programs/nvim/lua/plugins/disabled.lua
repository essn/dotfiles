return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      windows = {
        width_nofocus = 20,
        width_focus = 50,
        width_preview = 100,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
  },
}
