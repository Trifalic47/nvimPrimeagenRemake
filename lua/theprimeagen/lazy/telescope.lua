return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",
    keys = {
        { "<leader>pf", desc = "Find files" },
        { "<C-p>", desc = "Git files" },
        { "<leader>pws", desc = "Grep word" },
        { "<leader>pWs", desc = "Grep WORD" },
        { "<leader>ps", desc = "Grep input" },
        { "<leader>vh", desc = "Help tags" },
        { "<leader>man", desc = "Search Man Pages" },
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        local builtin = require('telescope.builtin')
        require('telescope').setup({
            defaults = {
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>man', function()
            require('telescope.builtin').man_pages({ sections = { "ALL" } })
        end, { desc = "Search Man Pages" })
    end
}
