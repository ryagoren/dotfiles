local nvim_command = vim.api.nvim_command

nvim_command('set tabstop=4')
nvim_command('set shiftwidth=4 smarttab')
nvim_command('set expandtab')


vim.cmd([[ set wildcharm=<C-Z>]])
vim.cmd([[ cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>" ]])
vim.cmd([[ cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>" ]])
vim.cmd([[ cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>" ]])
vim.cmd([[ cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>" ]])
