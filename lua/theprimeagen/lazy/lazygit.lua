return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>",                    { desc = "LazyGit" })
        vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitFilter<cr>",              { desc = "LazyGit File History" })
        vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>",   { desc = "LazyGit Current File" })
    end,

}
