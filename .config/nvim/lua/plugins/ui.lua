return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "b0o/incline.nvim",
    name = "incline",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = { "mini.icons" },
    config = function()
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local lazy_icons = LazyVim.config.icons
          local mini_icons = require("mini.icons")

          local function get_filename()
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            if filename == "" then
              filename = "[No Name]"
            end
            local ft_icon, ft_color = mini_icons.get("file", filename)
            local modified = vim.bo[props.buf].modified
            return {
              " ",
              { filename, gui = modified and "bold,italic" or "bold" },
              " ",
              ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
            }
          end

          local function get_diagnostics()
            local icons = {
              error = lazy_icons.diagnostics.Error,
              warn = lazy_icons.diagnostics.Warn,
              info = lazy_icons.diagnostics.Info,
              hint = lazy_icons.diagnostics.Hint,
            }
            local labels = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(labels, { " " .. icon .. n, group = "DiagnosticSign" .. severity })
              end
            end
            if #labels > 0 then
              table.insert(labels, { " ┊" })
            end
            return labels
          end

          local function get_mini_diff()
            local icons = {
              add = lazy_icons.git.added,
              change = lazy_icons.git.modified,
              delete = lazy_icons.git.removed,
            }
            local signs = vim.b[props.buf].minidiff_summary

            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { " ", icon .. signs[name], group = "MiniDiffSign" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { " 󰊢 " .. signs.n_ranges .. " ┊" })
            end
            return labels
          end

          local function get_grapple_status()
            local grapple_status
            grapple_status = require("grapple").name_or_index({ buffer = props.buf }) or ""
            if grapple_status ~= "" then
              grapple_status = { { " 󰛢 ", group = "Function" }, { grapple_status, group = "Constant" } }
            end
            return grapple_status
          end

          return {
            { get_diagnostics() },
            { get_mini_diff() },
            { get_grapple_status() },
            { get_filename() },
            group = props.focused and "ColorColumn" or "SignColumn",
          }
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
}
