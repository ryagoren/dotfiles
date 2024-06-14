local set = vim.keymap.set

-- keep cursor centered when jumpin' pages
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

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

-- pasting
set("n", "<leader><leader>x", "<cmd>source %<CR>")
set("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! ]c]]
  else
    vim.cmd [[m .+1<CR>==]]
  end
end)

set("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! [c]]
  else
    vim.cmd [[m .-2<CR>==]]
  end
end)
