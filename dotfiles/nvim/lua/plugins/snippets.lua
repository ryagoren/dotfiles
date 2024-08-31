return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		version="v2.*",
		config=function ()
			local ls=require "luasnip"
			local snippet_path = "/lua/snippets/"
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

			ls.config.set_config {
				history=true,
				enable_autosnippets=false,
			}

			vim.keymap.set({"i", "s"}, "<C-i>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, {silent = true})

			vim.api.nvim_create_user_command("ExpandSnippet", function(opts)
				local snip_name = opts.args
				local snippets = ls.get_snippets("c")
				if snippets and snippets[snip_name] then
					ls.snip_expand(snippets[snip_name])
				else
					print("snippet not found:", snip_name)
					print("available snippets:", vim.inspect(snippets))
				end
			end, {nargs = 1})

			vim.keymap.set({"i", "s"}, "<Tab>", "<Tab>", {silent = true, noremap = true})
			vim.keymap.set({"i", "s"}, "<S-Tab>", "<S-Tab>", {silent = true, noremap = true})

		end

	}
}
