vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

local keymap = vim.keymap
local opt = vim.opt

vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- save
keymap.set("n", "<leader>w", ":w<CR>")
--quit all buffers
keymap.set("n", "<leader>q", ":qa<CR>")
keymap.set(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[S]earch and [R]eplace" }
)
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- bulk move selected
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- split screen and navigation
keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true })
keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true })
keymap.set("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
keymap.set("n", "<leader>k", ":wincmd k<CR>", { noremap = true })

-- appearance
opt.relativenumber = true
opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 10
opt.colorcolumn = "100"

-- Don't show mode, since it's already in the status line
opt.showmode = false

-- Configure how new splites should be opened
opt.splitright = true
opt.splitbelow = true

-- tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.iskeyword:append("-") -- consider string-string as whole word

local icons = require("config.icons")
vim.fn.sign_define("DiagnosticSignError", { text = icons.diagnostics.Error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = icons.diagnostics.Warning, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icons.diagnostics.Info, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = icons.diagnostics.Hint, texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = {
		highlight_whole_line = false,
	},
})
