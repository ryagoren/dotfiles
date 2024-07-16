return {
	{
		"ellisonleao/gruvbox.nvim",
		config=function() 
			vim.o.background = "dark"
			require("gruvbox").setup()
			vim.keymap.set('n', '<leader>bg', ':colorscheme gruvbox<CR>')
		end,
	},
	{
		"samharju/synthweave.nvim",
		config=function() 
			vim.keymap.set('n', '<leader>bs', ':colorscheme synthweave<CR>')
		end
	},
	{
		"maxmx03/fluoromachine.nvim",
		priority=1000,
		config=function() 
			local fm = require 'fluoromachine'
			fm.setup {
				flow = true,
				--theme='delta',
				theme='fluoromachine',
				-- theme='retrowave',
			}
			vim.cmd("colorscheme fluoromachine")
			vim.keymap.set('n', '<leader>bf', ':colorscheme fluoromachine<CR>')
		end
	},
	{
		'cuencapablo/rosebones',
		opts = {},
		config=function() 
			vim.keymap.set('n', '<leader>brb', ':colorscheme rosebones<CR>')
		end
	},
	{
		'rktjmp/lush.nvim',
		lazy=false,
		config=function() 
			vim.keymap.set('n', '<leader>blh', ':LushRunTutorial<CR>')
		end
	},
	{
		dir='/home/ryangeor/git/goldle', 
		lazy = false,
		config=function() 
			vim.keymap.set('n', '<leader>bm', ':colorscheme goldle<CR>')
		end
	}

}

