return {
	{
		"ggandor/leap.nvim",
		dependencies={
			"tpope/vim-repeat"
		},
		enable=false,
		config = function()
			require("leap").create_default_mappings()
		end,
	},

}
