local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim... (wait)")
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",  -- faster, less hanging
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "theprimeagen.lazy",
    change_detection = { notify = false },
    rocks = {
        enabled = false,
        hererocks = false,
    },
})
