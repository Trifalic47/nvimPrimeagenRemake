return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "▎" },
                untracked    = { text = "▎" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = { follow_files = true },
            attach_to_untracked = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
            },
            current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> • <summary>",

            -- Keymaps
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", gs.next_hunk,   { desc = "Next Hunk" })
                map("n", "[h", gs.prev_hunk,   { desc = "Prev Hunk" })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk,   { desc = "Stage Hunk" })
                map("n", "<leader>hr", gs.reset_hunk,   { desc = "Reset Hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
                map("n", "<leader>hd", gs.diffthis,     { desc = "Diff This" })

                -- Toggle
                map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
                map("n", "<leader>td", gs.toggle_deleted,            { desc = "Toggle Deleted" })
            end,
        })
    end,
}
