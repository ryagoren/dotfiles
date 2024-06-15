local set = vim.keymap.set

-- keep cursor centered 
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

---- make macro mispresses harder 
set('n', '<leader>q', 'q')
set('n', 'q', '<Nop>')

set('n', "<leader>b", ":set invrelativenumber<CR>")

-- paste without adding selected to rm reg
set('x', "<leader>p", [["_dP]])

set("n", "<left>", "gT")
set("n", "<right>", "gt")

--set('n', "<leader>e", [[:edit <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = true, silent = true })
--set('n', "<leader>tabe", [[:edit <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = true, silent = true })
--set('n', '<leader>vs', [[:edit <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = true, silent = true })
--set('n', '<leader>split', [[:edit <C-R>=expand("%:p:h") . "/"<CR>]], { noremap = true, silent = true })
--set('n', "<leader>e", ":edit <C-R>=fnamemodify(@%, ':p:h')<CR>", { noremap = true, silent = true })

--nnoremap <leader>e :edit <C-R>=fnamemodify(@%, ':p:h')<CR>/
--set("n", "<leader><leader>x", "<cmd>source %<CR>")
-- pasting
--
set('n', '<leader>z', ':set invlist<cr>')

set('n', 'n', 'nzz', { silent = true })
set('n', 'N', 'Nzz', { silent = true })
set('n', '*', '*zz', { silent = true })
set('n', '#', '#zz', { silent = true })
set('n', 'g*', 'g*zz', { silent = true })

vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4 smarttab')
vim.api.nvim_command('set expandtab')
