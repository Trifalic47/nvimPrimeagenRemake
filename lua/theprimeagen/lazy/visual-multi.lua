return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        -- Setting g:VM_maps before the plugin loads
        vim.g.VM_maps = {
            ["Add Cursor Down"] = "<M-j>",
            ["Add Cursor Up"] = "<M-k>",
        }
    end,
}
