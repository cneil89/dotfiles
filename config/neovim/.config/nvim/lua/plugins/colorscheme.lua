return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            commentStyle = { italic = false },
            keywordStyle = { italic = false },
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            background = {
                dark = "wave",
                light = "lotus",
            },
        })
        vim.cmd.colorscheme("kanagawa")
    end,
}
