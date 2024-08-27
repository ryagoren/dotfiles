return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		version="v2.*",
		config=function ()
			local ls=require "luasnip"
			local snippet_path = "lua/snippets"
			local snippet_files = vim.api.nvim_get_runtime_file(snippet_path .. "*.lua", true)
			for _, fpath in ipairs(snippet_files) do
				local filename = vim.fn.fnamemodify(fpath, ":t:r")
				local chunk = loadfile(fpath)
				if chunk then
					local snippets = chunk()
					if type(snippets) == "table" then
						ls.add_snippets(filename, snippets)
					end
				end
				loadfile(fpath)()
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.active=function(filter)
				filter = filter or {}
				if filter.direction == 1 then
					return ls.expand_or_jumpable
				else
					return ls.jumpable(filter.direction)
				end
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.jump = function(direction)
				if direction == 1 then
					if ls.expandable() then
						return ls.expand_or_jump()
					else
						return ls.jumpable(1) and ls.jump(1)
					end
				else
					return ls.jumpable(-1) and ls.jump(-1)
				end
			end

			vim.snippet.stop = ls.unlink_current

			ls.config.set_config {
				history=true,
				updateevents="TextChanged,TextChangedI",
				override_builtin=true,
			}


			vim.keymap.set({"i", "s"}, "<leader><C-K>", function()
				return vim.snippet.active{direction=1} and vim.snippet.jump(1)
			end, {silent=true})

			vim.keymap.set({"i", "s"}, "<leader><C-L>", function()
				return vim.snippet.active{direction=1} and vim.snippet.jump(1)
			end, {silent=true})

		end

	}
}
