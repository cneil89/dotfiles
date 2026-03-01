return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        { "j-hui/fidget.nvim",       opts = {} },
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup()

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
    end,
}
