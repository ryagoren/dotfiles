return  {
	{
		"stevearc/conform.nvim",
		config=function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					cpp = {"clang-format"},
					c = {"clang-format"},
				},
				formatters={
					clang_format={
						prepend_args={ "--style={UseTab: Always, IndentWidth: 4}" }
					},
				}
			})
			vim.keymap.set({"n","v"}, "<leader>fm", function()
				conform.format({
					lsp_fallback=true,
					async=false,
					timeout_ms=1000,
				})
			end)
		end
	}

}
