return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("neogit").setup({
            disable_hint = false,
            disable_context_highlighting = false,
            disable_signs = false,
            graph_style = "unicode",
            git_services = {
                ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
                ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/create?merge_request[source_branch]=${branch_name}",
            },
            integrations = {
                telescope  = true,
                diffview   = true,
            },
            sections = {
                untracked = { folded = false, hidden = false },
                unstaged  = { folded = false, hidden = false },
                staged    = { folded = false, hidden = false },
                stashes   = { folded = true,  hidden = false },
                unpulled_upstream  = { folded = true, hidden = false },
                unmerged_upstream  = { folded = false, hidden = false },
                unpulled_pushremote = { folded = true, hidden = false },
                unmerged_pushremote = { folded = false, hidden = false },
                recent    = { folded = true,  hidden = false },
            },
            signs = {
                hunk        = { "", "" },
                item        = { "", "" },
                section     = { "", "" },
            },
        })

        vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>",             { desc = "Neogit" })
        vim.keymap.set("n", "<leader>nd", "<cmd>DiffviewOpen<cr>",       { desc = "Diff View" })
        vim.keymap.set("n", "<leader>nh", "<cmd>DiffviewFileHistory<cr>", { desc = "File History" })
        vim.keymap.set("n", "<leader>nc", "<cmd>DiffviewClose<cr>",      { desc = "Close Diff" })
    end,
}
