require("keymaps")
require("options")
require("autocmds")
require("autoclose").setup()
require("ibl").setup()
require("telescope")
require("nvim-treesitter.configs").setup {
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
