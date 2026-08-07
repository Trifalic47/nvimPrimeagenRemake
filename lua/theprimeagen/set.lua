vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.clipboard:append("unnamedplus")
vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "no"
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.fillchars = { eob = " " }
vim.wo.relativenumber = true
vim.opt.colorcolumn = "120"
vim.api.nvim_set_hl(0, "ColorColumn", {
    bg = "#111111"
})

vim.opt.autoindent = true
vim.opt.cindent = true

