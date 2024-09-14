return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- local colors = {
		--     blue = "#65d1ff",
		--     green = "#3effdc",
		--     violet = "#ff61ef",
		--     yellow = "#ffda7b",
		--     black = "#000000",
		--     dark_gray = "#302e2f",
		-- }
		--
		-- local dark_bar = {
		--     normal = {
		--         a = { bg = colors.blue, fg = colors.black },
		--         b = { bg = colors.dark_gray, fg = colors.blue },
		--         c = { bg = colors.dark_gray },
		--     },
		--     insert = {
		--         a = { bg = colors.green, fg = colors.black },
		--         b = { bg = colors.dark_gray, fg = colors.green},
		--         c = { bg = colors.dark_gray },
		--     },
		--     visual = {
		--         a = { bg = colors.violet, fg = colors.black},
		--         b = { bg = colors.dark_gray, fg = colors.violet },
		--         c = { bg = colors.dark_gray},
		--     },
		--     command = {
		--         a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
		--         b = {bg = colors.dark_gray, fg = colors.yellow},
		--         c = {bg = colors.dark_gray},
		--     }
		-- }

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
			},
		})
	end,
}
