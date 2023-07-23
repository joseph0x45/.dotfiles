require("pigeon")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	command = "setlocal shiftwidth=2 tabstop=2"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "svelte",
	command = "setlocal shiftwidth=2 tabstop=2"
})
