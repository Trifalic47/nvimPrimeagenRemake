return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local rose_pine_colors = {
            base    = "#232136",
            surface = "#2a273f",
            overlay = "#393552",
            muted   = "#6e6a86",
            subtle  = "#908caa",
            text    = "#e0def4",
            love    = "#eb6f92",
            gold    = "#f6c177",
            rose    = "#ea9a97",
            pine    = "#3e8fb0",
            foam    = "#9ccfd8",
            iris    = "#c4a7e7",
        }

        local theme = {
            normal = {
                a = { fg = rose_pine_colors.base, bg = rose_pine_colors.pine, gui = "bold" },
                b = { fg = rose_pine_colors.text, bg = rose_pine_colors.overlay },
                c = { fg = rose_pine_colors.subtle, bg = rose_pine_colors.base },
            },
            insert = {
                a = { fg = rose_pine_colors.base, bg = rose_pine_colors.foam, gui = "bold" },
                b = { fg = rose_pine_colors.text, bg = rose_pine_colors.overlay },
                c = { fg = rose_pine_colors.subtle, bg = rose_pine_colors.base },
            },
            visual = {
                a = { fg = rose_pine_colors.base, bg = rose_pine_colors.iris, gui = "bold" },
                b = { fg = rose_pine_colors.text, bg = rose_pine_colors.overlay },
                c = { fg = rose_pine_colors.subtle, bg = rose_pine_colors.base },
            },
            replace = {
                a = { fg = rose_pine_colors.base, bg = rose_pine_colors.love, gui = "bold" },
                b = { fg = rose_pine_colors.text, bg = rose_pine_colors.overlay },
                c = { fg = rose_pine_colors.subtle, bg = rose_pine_colors.base },
            },
            command = {
                a = { fg = rose_pine_colors.base, bg = rose_pine_colors.gold, gui = "bold" },
                b = { fg = rose_pine_colors.text, bg = rose_pine_colors.overlay },
                c = { fg = rose_pine_colors.subtle, bg = rose_pine_colors.base },
            },
            inactive = {
                a = { fg = rose_pine_colors.muted, bg = rose_pine_colors.base },
                b = { fg = rose_pine_colors.muted, bg = rose_pine_colors.base },
                c = { fg = rose_pine_colors.muted, bg = rose_pine_colors.base },
            },
        }

        require("lualine").setup({
            options = {
                theme = theme,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = false,  -- change this
                disabled_filetypes = { "TelescopePrompt" },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str) return " " .. str end,
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = "󰘬",
                        color = { fg = rose_pine_colors.iris },
                    },
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                        diff_color = {
                            added    = { fg = rose_pine_colors.foam },
                            modified = { fg = rose_pine_colors.gold },
                            removed  = { fg = rose_pine_colors.love },
                        },
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        symbols = {
                            modified = "  ",
                            readonly = "  ",
                            unnamed  = "  ",
                        },
                        color = { fg = rose_pine_colors.text },
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        symbols = {
                            error = " ",
                            warn  = " ",
                            info  = " ",
                            hint  = "󰠠 ",
                        },
                        diagnostics_color = {
                            error = { fg = rose_pine_colors.love },
                            warn  = { fg = rose_pine_colors.gold },
                            info  = { fg = rose_pine_colors.foam },
                            hint  = { fg = rose_pine_colors.iris },
                        },
                    },
                    {
                        "filetype",
                        icon_only = false,
                        color = { fg = rose_pine_colors.subtle },
                    },
                },
                lualine_y = {
                    {
                        "progress",
                        color = { fg = rose_pine_colors.muted },
                    },
                },
                lualine_z = {
                    {
                        "location",
                        fmt = function(str) return " " .. str end,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
