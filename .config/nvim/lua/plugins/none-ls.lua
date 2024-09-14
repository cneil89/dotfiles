return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				-- null_ls.builtins.formatting.templ,
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				null_ls.builtins.diagnostics.cppcheck.with({
					extra_args = { "--language=c++", "--project=compile_commands.json" },
				}),
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
