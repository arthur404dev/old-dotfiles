return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          -- Additional settings for bashls if needed
          filetypes = { "sh", "zsh" }, -- Ensure `.zsh` files are also supported
        },
      },
    },
  },
}
