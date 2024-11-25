return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.filetype.add({
        filename = {
          ["catppuccin.conf"] = "tmux",
          ["sesh.conf"] = "tmux",
          ["rose_pine.conf"] = "tmux",
        },
      })
    end,
    opts = {
      ensure_installed = {
        "bash",
        "ini",
        "go",
        "tmux",
      },
    },
  },
}
