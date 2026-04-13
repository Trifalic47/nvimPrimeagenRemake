return {
    -- TODO:
    -- NOTE:
    -- FIX:
    -- HACK:
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup({
            signs = true,
            sign_priority = 8,
            keywords = {
                FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning", alt = { "HACK" } },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ",                   alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint",   alt = { "INFO" } },
                TEST = { icon = "⏱ ", color = "test",  alt = { "TESTING", "PASSED", "FAILED" } },
            },
            colors = {
                error   = { "#eb6f92" },  -- rose pine love
                warning = { "#f6c177" },  -- rose pine gold
                info    = { "#3e8fb0" },  -- rose pine pine
                hint    = { "#9ccfd8" },  -- rose pine foam
                test    = { "#c4a7e7" },  -- rose pine iris
            },
            highlight = {
                before      = "",
                keyword     = "wide_bg",
                after       = "fg",
                pattern     = [[.*<(KEYWORDS)\s*:]],
                comments_only = true,
            },
        })

        -- Keymaps
        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next TODO" })
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev TODO" })
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
    end,
}
