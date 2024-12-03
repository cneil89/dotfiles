return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"clangd",
				"cmake",
				"templ",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
						capabilities = capabilities,
					})
				end,
			},
		})

		-- local servers = { "gopls", "ccls", "cmake", "templ" }
		-- for _, lsp in ipairs(servers) do
		--     lspconfig[lsp].setup({
		--         on_attach = on_attach,
		--         capabilities = capabilities,
		--     })
		-- end

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "on_attach", "capabilities" },
					},
				},
			},
		})

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
	end,
}
