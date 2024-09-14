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

return {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("eldritch").setup({
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
            },
        })
        vim.cmd.colorscheme("eldritch")
    end,
}
