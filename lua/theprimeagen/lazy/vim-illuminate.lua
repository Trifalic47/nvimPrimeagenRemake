return {
    "RRethy/vim-illuminate",
    config = function()

        require("illuminate").configure({
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetype_overrides = {},
            filetypes_denylist = {
                "dirbuf",
                "dirvish",
                "fugitive",
                "TelescopePrompt",
                "oil",
            },
            under_cursor = true,
            large_file_cutoff = nil,
            large_file_overrides = nil,
            min_count_to_highlight = 1,
        })

        -- Rose Pine Moon highlight colors
        vim.api.nvim_set_hl(0, "IlluminatedWordText",  { bg = "#393552" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead",  { bg = "#393552" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#44415a" })
        vim.keymap.set("n", "<leader>in", function()
            require("illuminate").goto_next_reference()
        end, { desc = "Next Reference" })
        vim.keymap.set("n", "<leader>ip", function()
            require("illuminate").goto_prev_reference()
        end, { desc = "Prev Reference" })
    end,
}
