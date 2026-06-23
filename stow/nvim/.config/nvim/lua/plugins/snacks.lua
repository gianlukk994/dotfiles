return {
  "folke/snacks.nvim",
  opts = {
    exporter = {

      git_untracked = true,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
