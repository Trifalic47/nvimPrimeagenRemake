return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#eb6f92" }) -- rose pine love
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f6c177" }) -- rose pine gold
            vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#3e8fb0" }) -- rose pine pine
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ea9a97" }) -- rose pine rose
            vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#9ccfd8" }) -- rose pine foam
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#c4a7e7" }) -- rose pine iris
            vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#908caa" }) -- rose pine subtle
        end)

        require("ibl").setup({
            indent = {
                char = "▏",
                highlight = highlight,
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = false,
                highlight = { "Function", "Label" },
            },
            exclude = {
                filetypes = {
                    "help",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        })
    end,
}
