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
keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S]earch and [R]eplace" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half pagedown (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- bulk move selected
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- split screen and navigation
keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true, desc = "Vertical split and move to new split pane" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
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

opt.loadplugins = true

local icons = require("config.icons")
vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
        style = "minimal",
    },
})

keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ source = "line" })
end, { noremap = true, silent = true, desc = "Show float diagnostic for line" })

vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
