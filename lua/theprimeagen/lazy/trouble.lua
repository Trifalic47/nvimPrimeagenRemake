return {
    "folke/trouble.nvim",
    keys = {
        { "<leader>tt", desc = "Toggle Trouble" },
        { "[t", desc = "Next Trouble" },
        { "]t", desc = "Prev Trouble" },
    },
    config = function()
        require("trouble").setup({ })

        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end)

        vim.keymap.set("n", "[t", function()
            require("trouble").next({skip_groups = true, jump = true});
        end)

        vim.keymap.set("n", "]t", function()
            require("trouble").previous({skip_groups = true, jump = true});
        end)
    end
}
