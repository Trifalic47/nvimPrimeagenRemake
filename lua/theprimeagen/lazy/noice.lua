return {
    "folke/noice.nvim",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("notify").setup({
            max_width = 40,
            max_height = 5,
            minimum_width = 20,
            timeout = 2000,
            top_down = false,
            render = "compact",
            stages = "static",
        })

        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            notify = {
                enabled = false,
                view = "notify",
            },
            routes = {
                {
                    filter = {
                        event = "notify",
                        find = "No information available", -- or generic startup msgs
                    },
                    opts = { skip = true },
                },
            },
        })
    end
}
