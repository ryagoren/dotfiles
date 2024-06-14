local opt = vim.opt

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }
opt.clipboard = "unnamedplus"

-- fuk folding. rly. 
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

vim.opt.wrap = false
-- remove useless edit suggestions
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'


vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.vb = true

vim.opt.diffopt:append('iwhite')
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- see useful stuff - whitespace etc
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

vim.keymap.set('n', '<leader>;', '<cmd>Buffers<cr>')

vim.keymap.set('n', '<leader>z', ':set invlist<cr>')

vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

-- tentative, lets give it a go
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')
