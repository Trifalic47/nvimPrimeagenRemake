if vim.treesitter
    and vim.treesitter.language
    and not vim.treesitter.language.ft_to_lang then
    vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end
require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    callback = function()
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size < max_filesize then
            local view = vim.fn.winsaveview()
            vim.api.nvim_command([[silent! %s/\s\+$//e]])
            vim.fn.winrestview(view)
        end
    end,
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(false, { bufnr = e.buf })
        end
    end
})


 -- Man Page Configuration
 vim.api.nvim_create_autocmd("FileType", {
     pattern = "man",
     callback = function()
         vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true, silent = true })
         -- Use standard layout
     end,
 })

 -- Set keywordprg to use :Man
vim.opt.cursorline = true

vim.api.nvim_set_hl(0, "CursorLine", {
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "LineNr", {
    fg = "#565c64",
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#ffdd33",
    bg = "NONE",
    bold = true,
})vim.opt.keywordprg = ":Man"
