return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = { 'bash', 'go', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, _)
            local treesitter = require("nvim-treesitter")
            treesitter.setup({})
            local ensure_installed = {
                "vim",
                "vimdoc",
                "rust",
                "c",
                "cpp",
                "go",
                "html",
                "css",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "bash"
            }

            local config = require("nvim-treesitter.config")

            local already_installed = config.get_installed()
            local parsers_to_install = {}

            for _, parser in ipairs(ensure_installed) do
                if not vim.tbl_contains(already_installed, parser) then
                    table.insert(parsers_to_install, parser)
                end
            end

            if #parsers_to_install > 0 then
                treesitter.install(parsers_to_install)
            end

            local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                        vim.treesitter.start(args.buf)
                    end
                end
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end,
    },
}
