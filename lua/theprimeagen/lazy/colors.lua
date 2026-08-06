local function ColorMyPencils()
    vim.cmd.colorscheme("gruber-darker")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

return {
    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,

        opts = {
            bold = false,
            italic = {
                strings = false,
            },
        },

        config = function(_, opts)
            require("gruber-darker").setup(opts)
            ColorMyPencils()
        end,
    },
}
