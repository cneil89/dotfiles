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

local augroup = vim.api.nvim_create_augroup("Nomad-UserConfig", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    desc = "Highlight when yanking (copyinng) text",
    pattern = "*",
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore last cursor position",
    group = augroup,
    callback = function()
        if vim.o.diff then -- except in diff mode
            return
        end

        local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
        local last_line = vim.api.nvim_buf_line_count(0)

        local row = last_pos[1]
        if row < 1 or row > last_line then
            return
        end

        pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end
})

vim.cmd.colorscheme("tokyonight-night")

-- Enable LSP
local servers = { "gopls", "lua_ls", "terraformls" }
for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end
