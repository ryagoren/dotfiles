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

set('n', 'n', 'nzz', { silent = true })
set('n', 'N', 'Nzz', { silent = true })
set('n', '*', '*zz', { silent = true })
set('n', '#', '#zz', { silent = true })
set('n', 'g*', 'g*zz', { silent = true })

set('n', '<leader>z', ':set invlist<cr>')
--set( 'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

