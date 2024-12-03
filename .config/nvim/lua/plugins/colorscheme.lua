return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nordic").load()
		require("nordic").setup({
			transparent = {
				bg = false,
			},
			bright_border = true,
			reduced_blue = true,
			cursorline = {
				theme = "light",
				blend = 0.8,
			},
		})

		vim.cmd.colorscheme("nordic")
		vim.api.nvim_set_hl(0, "Visual", { bg = "#417372" })
	end,
}

-- return {
--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("kanagawa").setup({
--             commentStyle = { italic = false },
--             keywordStyle = { italic = false },
--             colors = {
--                 theme = {
--                     all = {
--                         ui = {
--                             bg_gutter = "none",
--                         },
--                     },
--                 },
--             },
--             background = {
--                 dark = "dragon",
--                 light = "lotus",
--             },
--         })
--         vim.cmd.colorscheme("kanagawa")
--     end,
-- }

-- return {
--     "eldritch-theme/eldritch.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--         require("eldritch").setup({
--             styles = {
--                 comments = { italic = false },
--                 keywords = { italic = false },
--             },
--         })
--         vim.cmd.colorscheme("eldritch")
--     end,
-- }
