return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>tf",
        function()
          if vim.b.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat for current buffer")
          else
            vim.cmd("FormatDisable!")
            vim.notify("Disabled autoformat for current buffer")
          end
        end,
        desc = "Toggle autoformat for current buffer",
      },
      {
        "<leader>tF",
        function()
          if vim.g.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat globally")
          else
            vim.cmd("FormatDisable")
            vim.notify("Disabled autoformat globally")
          end
        end,
        desc = "Toggle autoformat globally",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
