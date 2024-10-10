local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

vim.filetype.add({
	extention = {
		templ = "templ",
	},
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	desc = "Highlight when yanking (copyinng) text",
	pattern = "*",
	group = vim.api.nvim_create_augroup("niloc-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
