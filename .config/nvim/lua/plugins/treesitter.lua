return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "bash",

        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "prisma",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        vim.filetype.add({
          filename = {
            ["catppuccin_round.conf"] = "tmux",
            ["catppuccin_bar.conf"] = "tmux",
            ["sesh.conf"] = "tmux",
            ["rose_pine.conf"] = "tmux",
          },
        })
        -- MDX
        vim.filetype.add({
          extension = {
            mdx = "mdx",
          },
        })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },
  },
}
