require("config")
require("toodoo")

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.robot",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
