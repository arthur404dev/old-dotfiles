return {
  "saghen/blink.cmp",
  enabled = true,

  dependencies = {
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
  },
  opts = function(_, opts)
    opts.enabled = function()
      -- Get the current buffer's filetype
      local filetype = vim.bo[0].filetype

      -- Disable for Telescope buffers
      if filetype == "TelescopePrompt" or filetype == "minifiles" then
        return false
      end
      return true
    end

    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "path", "snippets", "buffer", "copilot", "dadbod", "emoji" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          kind = "LSP",
          -- When linking markdown notes, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no LSP
          -- suggestions
          --
          -- Enabled fallbacks as this seems to be working now
          -- Disabling fallbacks as my snippets wouldn't show up when editing
          -- lua files
          -- fallbacks = { "snippets", "buffer" },
          score_offset = 90, -- the higher the number, the higher the priority
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          -- When typing a path, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no path
          -- suggestions
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          score_offset = 15, -- the higher the number, the higher the priority
        },
        -- https://github.com/moyiz/blink-emoji.nvim
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- the higher the number, the higher the priority
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },
      },
    })

    opts.completion = {
      --   keyword = {
      --     -- 'prefix' will fuzzy match on the text before the cursor
      --     -- 'full' will fuzzy match on the text before *and* after the cursor
      --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      --     range = "full",
      --   },
      menu = {
        border = "single",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
      },
    }

    -- opts.fuzzy = {
    --   -- Disabling this matches the behavior of fzf
    --   use_typo_resistance = false,
    --   -- Frecency tracks the most recently/frequently used items and boosts the score of the item
    --   use_frecency = true,
    --   -- Proximity bonus boosts the score of items matching nearby words
    --   use_proximity = false,
    -- }

    -- opts.snippets = {
    --   preset = "luasnip",
    --   -- This comes from the luasnip extra, if you don't add it, won't be able to
    --   -- jump forward or backward in luasnip snippets
    --   -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
    --   expand = function(snippet)
    --     require("luasnip").lsp_expand(snippet)
    --   end,
    --   active = function(filter)
    --     if filter and filter.direction then
    --       return require("luasnip").jumpable(filter.direction)
    --     end
    --     return require("luasnip").in_snippet()
    --   end,
    --   jump = function(direction)
    --     require("luasnip").jump(direction)
    --   end,
    -- }

    -- opts.keymap = {
    --   preset = "default",
    --   ["<Tab>"] = { "snippet_forward", "fallback" },
    --   ["<S-Tab>"] = { "snippet_backward", "fallback" },
    --
    --   ["<Up>"] = { "select_prev", "fallback" },
    --   ["<Down>"] = { "select_next", "fallback" },
    --   ["<C-p>"] = { "select_prev", "fallback" },
    --   ["<C-n>"] = { "select_next", "fallback" },
    --
    --   ["<S-k>"] = { "scroll_documentation_up", "fallback" },
    --   ["<S-j>"] = { "scroll_documentation_down", "fallback" },
    --
    --   ["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
    --   -- ["<C-e>"] = { "hide", "fallback" },
    -- }

    return opts
  end,
}
