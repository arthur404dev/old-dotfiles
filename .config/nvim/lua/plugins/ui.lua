local colors = {
  bg = "#1e1e2e",
  fg = "#cdd6f4",
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  subtext_1 = "#a6adc8",
  subtext_0 = "#bac2de",
  overlay_2 = "#9399b2",
  overlay_1 = "#7f849c",
  overlay_0 = "#6c7086",
  surface_2 = "#585b70",
  surface_1 = "#45475a",
  surface_0 = "#313244",
  mantle = "#181825",
  crust = "#11111b",
}

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
              table.insert(labels, { " |" })
            end
            return labels
          end

          local function get_grapple_status()
            local grapple_status
            grapple_status = require("grapple").name_or_index({ buffer = props.buf }) or ""
            if grapple_status ~= "" then
              grapple_status = { { " 󰛢 ", guifg = colors.sky }, { grapple_status, guifg = colors.sky } }
            end
            return grapple_status
          end

          return {
            { get_diagnostics() },
            { get_grapple_status() },
            { get_filename() },
            guibg = props.focused and colors.mantle or colors.surface_0,
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
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
  ░░░░░░░█▐▓▓░████▄▄▄█▀▄▓▓▓▌█
  ░░░░░▄█▌▀▄▓▓▄▄▄▄▀▀▀▄▓▓▓▓▓▌█
  ░░░▄█▀▀▄▓█▓▓▓▓▓▓▓▓▓▓▓▓▀░▓▌█
  ░░█▀▄▓▓▓███▓▓▓███▓▓▓▄░░▄▓▐█▌
  ░█▌▓▓▓▀▀▓▓▓▓███▓▓▓▓▓▓▓▄▀▓▓▐█
  ▐█▐██▐░▄▓▓▓▓▓▀▄░▀▓▓▓▓▓▓▓▓▓▌█▌
  █▌███▓▓▓▓▓▓▓▓▐░░▄▓▓███▓▓▓▄▀▐█
  █▐█▓▀░░▀▓▓▓▓▓▓▓▓▓██████▓▓▓▓▐█
  ▌▓▄▌▀░▀░▐▀█▄▓▓██████████▓▓▓▌█▌
  ▌▓▓▓▄▄▀▀▓▓▓▀▓▓▓▓▓▓▓▓█▓█▓█▓▓▌█▌
  █▐▓▓▓▓▓▓▄▄▄▓▓▓▓▓▓█▓█▓█▓█▓▓▓▐█

███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
       [ @arthur404dev ]
    ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
