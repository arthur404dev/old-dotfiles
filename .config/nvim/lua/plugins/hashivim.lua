return {
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" }, -- Load for .tf and .hcl files
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },
}
