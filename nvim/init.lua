vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.robot",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<A-w>l", ":wincmd l<CR>")
vim.keymap.set("n", "<A-w>k", ":wincmd k<CR>")
vim.keymap.set("n", "<A-w>j", ":wincmd j<CR>")
vim.keymap.set("n", "<A-w>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader><leader>x", ":source ~/.dotfiles/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/m4xshen/autoclose.nvim" },
	{ src = "https://github.com/joseph0x45/md_todo" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/terrortylor/nvim-comment" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("autoclose").setup()
require("ibl").setup()
require('nvim_comment').setup()
-- md_todo
local todo = require("md_todo")
vim.keymap.set("n", "<leader>md", function ()
  todo.toggle_state()
end)
vim.keymap.set("n", "<leader>mn", function ()
  todo.create_todo()
end)
-- md_todo
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
-- telescope
-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  autotag = {
    enable = true,
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-- treesitter

-- blink
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
-- require("blink.cmp").setup({
-- 	keymap = { preset = 'enter' },
-- 	appearance = {
-- 		nerd_font_variant = 'mono',
--     highlight_ns = 0,
-- 	},
-- 	completion = { documentation = { auto_show = true } },
-- 	sources = {
-- 		default = { 'lsp', 'path', 'snippets', 'buffer' },
-- 	},
-- 	fuzzy = { implementation = "prefer_rust" }
-- })
-- blink

-- LSP --
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
})

vim.cmd[[set completeopt+=menuone,noselect,popup]]
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return not action.disabled
			end,
		})
	end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

vim.lsp.config("gopls", { on_attach = on_attach })
vim.lsp.config("pylsp", { on_attach = on_attach })
vim.lsp.config("html-lsp", { on_attach = on_attach })

