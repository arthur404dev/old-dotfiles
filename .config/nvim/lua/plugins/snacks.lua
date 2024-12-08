return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        -- configure = true,
        config = {
          theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "~/.config/lazygit/config.yml"),
        },
      },
      notifier = {
        top_down = false,
      },
    },
  },
}
