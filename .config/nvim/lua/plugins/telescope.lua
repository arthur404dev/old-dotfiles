return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
          },
        },
      },
      config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
      end,
    },
  },
  -- File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<leader>sB",
        ":Telescope file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browse Files",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
