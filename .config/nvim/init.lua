if vim.g.vscode then
  -- VSCode Neovim
  require("user.vscode")
else
  -- Ordinary Neovim
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
