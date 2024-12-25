return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {},
    },
    config = function(_, opts)
      opts.highlight_overrides = {
        all = function(colors)
          return {
            -- NeoTreeNormal = { fg = colors.text, bg = colors.base },
            -- NeoTreeNormalNC = { fg = colors.text, bg = colors.base },
            WinSeparator = { fg = colors.mantle, bg = colors.mantle },
          }
        end,
      }
      require("catppuccin").setup(opts)
    end,
  },
}
