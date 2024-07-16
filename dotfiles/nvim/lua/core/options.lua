local opt = vim.opt

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.undofile = true

opt.splitbelow = true
opt.splitright = true
--opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

-- fuk folding. rly. 
opt.foldenable = false
opt.foldmethod = 'manual'
opt.foldlevelstart = 99

opt.wrap = false
-- remove useless edit suggestions

opt.wildmode = 'list:longest'
opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'

opt.ignorecase = true
opt.smartcase = true
opt.vb = true

opt.diffopt:append('iwhite')
opt.diffopt:append('algorithm:histogram')
opt.diffopt:append('indent-heuristic')
opt.shortmess=""

opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

if vim.fn.executable("rg") then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end


