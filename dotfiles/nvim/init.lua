--vim.api.nvim_command('set runtimepath^=~/.config/nvim')
--vim.api.nvim_command('set runtimepath^=~/.config/nvim/lua')
--vim.api.nvim_command('set runtimepath^=~/.local/site/nvim')
--vim.api.nvim_command('set runtimepath^=~/.local/share/nvim')
--vim.api.nvim_command('set runtimepath^=~/.local/nvim/site/after')
--vim.api.nvim_command('let &packpath = &runtimepath')

vim.g.mapleader =','
vim.g.maplocalleader = ','

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})

require("binds")
require("options")
