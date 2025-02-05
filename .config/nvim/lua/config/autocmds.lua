-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local api = vim.api

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hbs",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local base_extension = bufname:match("([^%.]+)%.hbs$")

    if base_extension then
      vim.bo.filetype = base_extension
      vim.bo.syntax = base_extension
    end
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hbs",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local base_extension = bufname:match("([^%.]+)%.hbs$")

    if base_extension then
      -- Set the correct filetype and syntax
      vim.bo.filetype = base_extension
      vim.bo.syntax = base_extension

      -- Set up LSP-based formatting dynamically
      local conform = require("conform")
      local formatters = conform.list_formatters(0) -- Get available formatters for this buffer

      if next(formatters) then
        -- Enable autoformat using LSP (avoid minifiers)
        vim.b.autoformat = true
        vim.b.formatters = formatters
      end
    end
  end,
})
