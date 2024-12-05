return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    opts = {
      config = function(_, opts)
        local telescope = require("telescope")
        telescope.configs.setup(opts)
        telescope.load_extension("live_grep_args")
      end,
    },
  },
}
