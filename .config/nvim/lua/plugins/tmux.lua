return {
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = { enable = false },
        resize = {
          enable_default_keybindings = false,
        },
      })
    end,
  },
}
